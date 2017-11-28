1.) Rails Gem: gem 'geocoder'
    rails g migration add_address_into_to_user street postal_code city province country latitude:float longitude:float 
    rails db:migrate
2.) update new user form
    2.1) update user controller:
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :street, :city, :province, :postal_code, :country)
    end
3.) update user.rb:
    geocoded_by :full_street_address   # can also be an IP address
    after_validation :geocode          # auto-fetch coordinates

    def full_street_address
        "#{street} #{postal_code} #{city} #{province} #{country}"
    end
4.) gmaps for rails: 
    #Node - possible to grab javascript libraires and go from there.
    gem 'gmaps4rails'
    4.1) update user.rb
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :history, :finders]

    def slug_candidates
        [
            [:first_name, :last_name, :city, :street]
        ]
    end

    4.2) rails g migration add_slug_to_users slug && rails db:migrate
5.) Update routes:
resources :users, only [:new, :create, :show]
6.) users_controller:
def show
    @user = User.find params[:id]
end
7.) views ... show.html.erb
=begin
    <h1><%= @user.full_name %></h1>

    <!-- put map here -->
    <div style='width: 800px;'>
        <div id="map" style='width: 800px; height: 400px;'></div>
    </div>
=end
8.) update Product Show Page: 
<p>By <%= link_to @product.user&.full_name, @product.user %></p>
9.) update application/layout.html.erb:
=begin
<script src="//maps.google.com/maps/api/js?key=[your API key]"></script>
    <script src="//cdn.rawgit.com/mahnunchik/markerclustererplus/master/dist/markerclusterer.min.js"></script>
    <script src='//cdn.rawgit.com/printercu/google-maps-utility-library-v3-read-only/master/infobox/src/infobox_packed.js' type='text/javascript'></script> <!-- only if you need custom infoboxes -->


    ...

    <% if user_signed_in? %>
        <li class="nav-item">
            <a class="nav-link" href="<%= user_path(current_user) %>"><strong>Hello <%= current_user.full_name %></strong></a>
        </li>
=end
10.) Get an API Key: https://developers.google.com/maps/documentation/javascript/get-api-key
    10.1) put into [your API key] section in code above.
11.)https://github.com/rweng/underscore-rails
    gem 'underscore-rails'
    gem 'country_select'
    11.1) add to application.js:
    //= require underscore
    //= require gmaps/google
12.) Update views/users/new.html.erb:
=begin
    <h2>Address Info</h2>
    <%= f.input :street %>
    <%= f.input :city %>
    <%= f.input :postal_code %>
    <%= f.input :province %>
    <%= f.input :country %>
=end
13.) in views/users/show.html.erb 
=begin 
<script>
  const handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  markers = handler.addMarkers([
    {
      "lat": <%= @user.latitude %>,
      "lng": <%= @user.longitude %>,
      "infowindow": "<%= @user.full_name %> location"
    }
  ]);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
  handler.getMap().setZoom(17)
  });
</script>
=end 

14.) rails g controller nearby_users --no-helper --no-assets
15.) routes.rb
resources :nearby_users, only: [:index]
16.) nearby_users controller 
class NearbyUsersController < ApplicationController
  def index
  end
end
17.) create views/nearby_users/index.html.erb 
<h1>Nearby Users</h1>
18.) update application.html.erb 
in nav bar: <%=# link_to 'Nearby Users', nearby_users_path %>
19.) javascript code to get current users location: https://developer.mozilla.org/en-US/docs/Web/API/Geolocation/Using_geolocation
navigator.geolocation.getCurrentPosition(function(position) {
  do_something(position.coords.latitude, position.coords.longitude);
});
20.) views/nearby_users/index.html.erb:
=begin
<% if !(session[:longitude] && session[:latitude]) %>
  <script>
    navigator.geolocation.getCurrentPosition(function(position) {
      console.log(position.coords.latitude, position.coords.longitude);
      window.location = `<%= nearby_users_path %>?longitude=${position.coords.longitude}&latitude=${position.coords.latitude}`
    });
  </script>
<% end %>
=end
21.) update NearbyUsersController: 
def index
    if params[:longitude] && params[:latitude]
      session[:longitude] = params[:longitude].to_f
      session[:latitude] = params[:latitude].to_f
    end
    if session[:latitude] && session[:longitude]
        @users = User.near([session[:latitude], session[:longitude]], 20, units: :km)
    end
end
22.) Update index.html.erb:
=begin

    <% if @users %>
        <% @users.each do |user| %>
            <%= user.full_name %>
            <hr>
        <% end %>
    <% end %>

=end

23.) update NearbyUsersController:
if session[:latitude] && session[:longitude]
    @users = User.near([session[:latitude], session[:longitude]], 20, units: :km)
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow "<a href='#{user_path(user)}'>#{user.full_name}</a>"
    end
end
24) update views/users/index.html.erb:
=begin
<% if @users %>
  <div style='width: 800px;'>
    <div id="map" style='width: 800px; height: 400px;'></div>
  </div>

  <script>
    const handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      markers = handler.addMarkers(<%= raw @hash.to_json %>);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    });
  </script>

<% end %>
=end
25.) Create a new users via the web:

    25.1)rails c
    long = User.last.longitude
    lat = User.last.latitude
    User.where(latitude: nil).each do |user|
        user.update(latitude: lat + rand / 5000, longitude: long + rand / 5000)
    end
    if previously set: User.all.update(latitude: lat + rand / 100, longitude: long + rand / 100)



