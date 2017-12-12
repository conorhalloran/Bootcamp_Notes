Major Benefit: No need for PCI Compliance. 

JS Library front End, Ruby Libary Backend. 

1.) rails g model gift amount:integer paid:boolean user:references answer:references message:text
    1.1) go into migration: t.boolean :paid, default: false
    1.2) rails db:migrate
2.) user.rb:
    has_many :gifts, dependent: :destroy
    has_many :gifted_awnsers, through: :gifts, source: :answer
3.) answer.rb: 
    has_many :gifts, dependent: :destroy
4.) rails g controller gifts --no-assets --no-helper
    4.1) In gifts_controller:
        before_action :authenticate_user!

        DEFAULT_GIFT_AMOUNT = 5

        def new
            @awnser = Answer.find params[:awnser_id]
            @gift = Gift.new amount: DEFAULT_GIFT_AMOUNT
        end

        def create
            @awnser = Answer.find params[:awnser_id]
            @gift = Gift.new gift_params
            if @gift.save

            else
                render :new
            end

        end

        private 
        def gift_params
            params.require(:gift).permit(:amount, :message)
        end
    4.2) update routes: 
        resources :questions do
        resources :answers, shallow: true, only: [:create, :destroy] do
            resources :votes, only: [:create, :destroy, :update]
            resources :gifts, only: [:new, :create]
        end
        resources :likes, shallow: true, only: [:create, :destroy]
    end
    4.3) check: localhost/rails/info/routes#
    4.3) in Views/Awnsers/_awnser.html.erb:
    # <%= link_to 'Give a gift 🎁', new_answer_gift_path(answer) %>
5) Create: Views/Gifts/new.html.erb 
=begin
        <h1>Give a Gift 🎁 </h1>
        <%= simple_form_for [@answer, @gift] do |f| %>
            <%= f.input :amount %>
            <%= f.input :message %>
            <%= f.submit 'Go To Payment', class: 'btn btn-primary' %>
        <% end %>
=end
6) Create a Payments Controller: rails g controller payments --no-assets --no-helper
    6.1) routes.rb 
            resources :gifts, only: [:new, :create] do
                resources :payments, only: [:new, :create]
            end
    6.2) gifts_controller
        def create 
            ...
            @gift.user = current_user
            @gift.answer = @answer
            if @gift.save
                redirect_to new_gift_payment_path(@gift)
                ..
    6.3) Create Views/Payments/new.html.erb 
        <h1>Make a Payment 💸 </h1>
    6.4) update gift.rb 
    validates :amount, presence: true, numericality: { greater_than: 0 }
7.) in Views/Trips/new.html.erb: 
=begin
   
<h1>Make a payment ð³</h1>

<%= form_tag '', id: 'credit-card-form' do %>
  <div class="form-group">
    <%= label_tag :number %>
    <%= text_field_tag :number, '', class: 'form-control' %>
  </div>
  <div class="form-group">
    <%= label_tag :expiry %>
    <%= select_month Date.today, { add_month_numbers: true },
                                 { class: 'form-control' } %>
    <%= select_year Date.today, { start_year: Date.today.year, end_year: Date.today.year + 10 },
                                 { class: 'form-control' } %>
  </div>

  <div class="form-group">
    <%= label_tag :cvc %>
    <%= text_field_tag :cvc, '', class: 'form-control' %>
  </div>

  <%= submit_tag 'Make Payment', class: 'btn btn-primary' %>

<% end %>


=end 
    
8.) Create a Strip Account. 
9.) Search for Stripe.js 
https://stripe.com/docs/stripe-js/reference
    9.1) in application.html.erb: 

    add to head: 
    # <script src="https://js.stripe.com/v3/"></script>
    9.2) Log into Stripe Account, Select API.
        Publishable Key: 
        Secret Key: 
    9.3) add publishable key under the stripe script 
=begin 
    <script src="https://js.stripe.com/v3/"></script>
    <script>
      const stripe = Stripe('pk_test_6pRNASCoBOKtIshFeQd4XMUh');
    </script>
=end 
10.) Create App/assets/javascript/payment.js
document.addEventListener('DOMContentLoaded', () => {

  const form = document.querySelector('#credit-card-form');
  const card = elements.create('card');
  card.mount('#card-element')

  form.addEventListener('submit', (event) => {
    event.preventDefault();

    stripe.createToken(card).then(function(result) {
      console.log(result);
      if (result.error) {
        // Inform the customer that there was an error
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        // Send the token to your server
        // stripeTokenHandler(result.token);
        alert(result.token.id);
      }
    });

  });

});

11.) Update views/payments/new.html.erb
=begin
    
<h1>Make a payment ð³</h1>

<%= form_tag '', id: 'credit-card-form' do %>

  <div id="card-element">
    <!-- a Stripe Element will be inserted here. -->
  </div>

  <div id="card-errors" role="alert"></div>
  <%= submit_tag 'Make Payment', class: 'btn btn-primary' %>

<% end %>

=end
12.) in payments_controller: 
class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @gift = Gift.find params[:gift_id]
  end

  def create
    render json: params
  end
end
13.) update new.html.erb 
=begin 

<h1>Make a payment ð³</h1>

<%= form_tag '', id: 'credit-card-form' do %>

  <div id="card-element">
    <!-- a Stripe Element will be inserted here. -->
  </div>

  <div id="card-errors" role="alert"></div>
  <%= submit_tag 'Make Payment', class: 'btn btn-primary' %>

<% end %>

<%= form_tag gift_payments_path(@gift), id: 'server-form' do %>
  <%= hidden_field_tag :stripe_token %>
<% end %>


=end 
14.) update payment.js 
=begin 

document.addEventListener('DOMContentLoaded', () => {

  const form = document.querySelector('#credit-card-form');

  // This will use the v3 Stripe api to automatically generate credit card
  // fields into the div with id: card-element
  const elements = stripe.elements();
  var card = elements.create('card');
  // Add an instance of the card Element into the `card-element` <div>
  card.mount('#card-element');


  form.addEventListener('submit', (event) => {
    event.preventDefault();

    stripe.createToken(card).then(function(result) {
      console.log(result);
      if (result.error) {
        // Inform the customer that there was an error
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        // Send the token to your server
        // alert(result.token.id);

        // set the stripe_token value inside the hidden field
        document.querySelector('#stripe_token').value = result.token.id;
        // submit the form to our server
        document.querySelector('#server-form').submit();
      }
    });

  });

});


=end 

################## RUBY GEM INSTALLATION ##################

1.) gem 'stripe' -- bundle 
2.) Setup Secret Key: app_keys.rb 
      ENV['STRIPE_SECRET_KEY'] = '<SECRET KEY>'
3.) CREATE setup_stripe.rb 
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
4.) Update payments_controller
    class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def new
        @gift = Gift.find params[:gift_id]
    end

    def create

        stripe_customer = Stripe::Customer.create(
                            description: "Customer for #{current_user.email}",
                            source: params[:stripe_token]
                            )

        puts '>>>>>>>>'
        puts stripe_customer.inspect
        puts '>>>>>>>>'

        render json: params
    end
    end
5.) rails g migation add_stripe_information_to_users stripe_customer_id stripe_card_brand stripe_card_exp_month:integer stripe_card_exp_year:integer
6.) update payments_controller:
    stripe_customer = Stripe::Customer.create(
                          description: "Customer for #{current_user.email}",
                          source: params[:stripe_token]
                        )

    card = stripe_customer.cards.data[0]
    current_user.update(stripe_customer_id: stripe_customer.id,
                       stripe_card_brand: card.brand,
                       card_exp_month: card.exp_month,
                       card_exp_year: card.exp_year)

    Stripe::Charge.create(
       amount: @gift.amount * 100,
       currency: 'cad',
       customer: current_user.stripe_customer_id,
       description: "Charge for Gift ID: #{@gift.id}"
     )
     @gift.update(paid: true)

    redirect_to @gift.answer.question, notice: 'Thanks for making the payment'
7.)