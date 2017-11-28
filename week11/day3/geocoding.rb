Geocoding System:

https://github.com/alexreisner/geocoder
1.) Rails Gem: gem 'geocoder'
    rails g migration Add_Address_into_to_User street postal_code city province country latitude:float longitude:float 
    rails db:migrate
2.) update new user form
    2.1) update user controller:
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :street, :city, :province, :postal, :country)
    end
3.) update user.rb:
    geocoded_by :full_street_address   # can also be an IP address
    after_validation :geocode          # auto-fetch coordinates

    def full_street_address
        "#{street} #{city} #{province} #{country} #{postal_code}"
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
6.) user controller:
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
8.) update Question Show Page: 
<p>By <%= link_to @question.user&.full_name, @question.user %></p>
9.) update application/layout.html.erb:
<script src="//maps.google.com/maps/api/js?key=[your API key]"></script>
    <script src="//cdn.rawgit.com/mahnunchik/markerclustererplus/master/dist/markerclusterer.min.js"></script>
    <script src='//cdn.rawgit.com/printercu/google-maps-utility-library-v3-read-only/master/infobox/src/infobox_packed.js' type='text/javascript'></script> <!-- only if you need custom infoboxes -->
10.) Get an API Key: https://developers.google.com/maps/documentation/javascript/get-api-key
    10.1) put into [your API key] section in code above.
11.)https://github.com/rweng/underscore-rails
    gem 'underscore-rails'
12.) add to application.js:
//= require underscore
//= require gmaps/google
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
23.) rails c
long = User.last.longitude
lat = User.last.latitude
User.where(latitude: nil).each do |user|
    user.update(latitude: lat + rand / 2000, longitude: long + rand / 2000)
end
if previously set: User.all.update(latitude: lat + rand / 100, longitude: long + rand / 100)
24.) update NearbyUsersController:
if session[:latitude] && session[:longitude]
    @users = User.near([session[:latitude], session[:longitude]], 20, units: :km)
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow "<a href='#{user_path(user)}'>#{user.full_name}</a>"
    end
end
25) update views/users/index.html.erb:
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
26.) rails g migration add_aasm_state_to_questions aasm_state
gem 'aasm'
27.) question.rb 
include AASM 

aasm whiny_transitions: false do
    state :draft, initial: true 
    state :published
    state :archived
    state :stale
    state :answered

    event :publish do 
    transitions from: :draft, to: :published
    end 

    event :archive do 
    transitions from: [:draft, :published, :stale], to: :archived
    end 

    event :mark_stale do 
    transitions from: :published, to: :stale
    end

    event :answer do 
    transitions from: :published, to: :answered
    end 
end
28.) Questions Controller: 
def index
    @questions = Question.where(aasm_state: [:published, :answered]).order(created_at: :desc)
end
def create 
    ...
    if @question.save 
        @question.answer!
        ...
    ...
end
  28.1)
  q = Question.last 
  q.publish! #true
Product.all.each {|p| p.publish!}