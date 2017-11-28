1.) rails new --api trip_b_great
    1.1) Gem File: 
        uncomment gem 'rack-cors'
        add gem 'rspec-rails', gem 'factory_bot_rails' to group :development, :test do
        add gem 'active_model_serializers', gem 'rack-attack', gem 'faker', github: 'stympy/faker', gem 'cowsay', '~> 0.3.0'

        group :development do
            gem 'pry' #pry gem itself
            gem 'pry-rails' #a gem that integrates pry with rails seemlessly
            gem 'hirb'
    1.2.) rails g rspec:install
    1.3) rails db:create
2.) setup rack-attack:
    2.1) Now update your config/application.rb file to include it into your middleware stack:

    module YourApp
    class Application < Rails::Application

        # ...

        config.middleware.use Rack::Attack
        config.middleware.insert_before 0, "Rack::Cors" do
            allow do
                origins '*'
                resource '*', :headers => :any, :methods => [:get, :post, :update, :destory, :options]
            end
        end
    end
    2.2) Create a new initializer file in config/initializers/rack_attack.rb to configure your Rack::Attack rules. The example below is very basic, and it should give a good starting point although you may have different requirements altogether.

    class Rack::Attack

        # `Rack::Attack` is configured to use the `Rails.cache` value by default,
        # but you can override that by setting the `Rack::Attack.cache.store` value
        Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

        # Allow all local traffic
        whitelist('allow-localhost') do |req|
            '127.0.0.1' == req.ip || '::1' == req.ip
        end

        # Allow an IP address to make 5 requests every 5 seconds
        throttle('req/ip', limit: 5, period: 5) do |req|
            req.ip
        end

        # Send the following response to throttled clients
        self.throttled_response = ->(env) {
            retry_after = (env['rack.attack.match_data'] || {})[:period]
            [
            429,
            {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
            [{error: "Throttle limit reached. Retry later."}.to_json]
            ]
        }
    end
2.) rails g scaffold Trip title description location start_date end_date days
rails g scaffold Auction title description end_date start_price:integer reserve_price:integer
rails g scaffold Bid bid_price:integer auction:references
3.) Test:
curl -H "Content-Type:application/json; charset=utf-8" -d '{"title":"Great", "description":"WoW Description", "start_date":"01/10/17", "end_date":"02/10/17"}' http://localhost:3000/trips

4.) update seeds.rb 
    Trip.destroy_all

    10.times.each do
        Trip.create(
            title: Faker::FunnyName.three_word_name, 
            description: Faker::MostInterestingManInTheWorld.quote,
            days: rand(1...10),
            location: Faker::LordOfTheRings.location,
            start_date: Faker::Time.between(DateTime.now - 10, DateTime.now),
            end_date: Faker::Time.between(DateTime.now, DateTime.now + 10)
        )
    end

    trips = Trip.all

    puts Cowsay.say("Created #{trips.count} trips", :ghostbusters)
5.) create-react-app Trip-b-great
    5.1) in package.json: "start": "PORT=3001 react-scripts start",
    5.2) in /src folder:
        5.3) mkdir components
        5.4) mkdir container - move app.js to this folder
        5.5) mkdir stylesheets - move all stylesheets to this folder
        5.6) mkdir lib - touch requests.js 
            const BASE_URL = 'http://localhost:3000';

            export const Trip = {
                getAll() {
                    return fetch(
                        `${BASE_URL}/trips`,
                        {
                            headers: { }
                        }
                    ).then(res => res.json());
                }
            };
6.) Update all links in index.js and app.js to reflect these changes.
    6.1) Update config/application.rb: 
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
7.) Make your TripsContainer.js :
    import React, { Component } from 'react';

    class TripsContainer extends Component {
        render() {
            return (
                <div>
                {this.state.auctions.map((auction) => {
                    return <AuctionDetails auction={auction} key={auction.id} />;
                })}
            </div>
            );
        }
    }

    export default TripsContainer;
8.) mkdir lib, touch request.js
    const BASE_URL = 'http://localhost:3000';

    export const Trip = {
        getAll() {
            return fetch(
                `${BASE_URL}/trips`,
                {
                    headers: { }
                }
            ).then(res => res.json());
        }
    };
9.) Fetching API Data with axios:
    yarn add axios --save
    9.1) Initialize Constructor with Empty Array:
    constructor(props) {
        super(props)
        this.state = {
            ideas: []
        }
    }
    componentDidMount() {
		Trip
			.getAll()
			.then(trips => { console.log(trips); this.setState({ trips: trips }); });
    }
10.) Create an TripDetails Component:
=begin
import React from 'react'

const TripDetails = ({ trip }) =>
    <div className="tile" key={trip.id}>
        <h4>{trip.title}</h4>
        <p>{trip.description}</p>
        <p>{trip.location}</p>
        <p>{trip.start_date}</p>
        <p>{trip.end_date}</p>
    </div>

export default TripDetails
=end
11.) Create User Authentication with JWT:
    11.1) Gem File: gem 'devise', gem 'jwt'
    11.2) rails g devise:install
    11.3) rails g devise User
    11.4) rails db:migrate
12.) create a class named JsonWebToken in lib/json_web_token.rb. This class will encapsulate the JWT token encoding and decoding logic. Like so:

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue
    nil
  end
end

13.) Add an initializer for including the JsonWebToken class in config/initializers/jwt.rb. Like so:

require 'json_web_token'
14.) reate an AuthenticationController to handle all authentication requests to the API. Like so:

In app/controllers/authentication_controller.rb:

class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end
end
15.) update routes: 
post 'auth_user' => 'authentication#authenticate_user'
get 'home' => 'home#index'


curl --header "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.jbYj4_w8vxNJLDzkCwn7di8BkAHEcdQysbfDxc0T97A" http://localhost:3000/home

16.) Update Requests.js with JWT Token: 
const BASE_URL = 'http://localhost:3000';

function getJwt() {
    return localStorage.getItem('jwt');
}

export const Auction = {
    getAll() {
        return fetch(
            `${BASE_URL}/auctions`,
            {
                headers: { 'Authorization': `JWT ${getJwt()}` }
            }
        ).then(res => res.json());
    }
};
17.) yarn add react-router-dom
    17.1) update app.js:
    import {
        BrowserRouter as Router, Route, Link } from 'react-router-dom';