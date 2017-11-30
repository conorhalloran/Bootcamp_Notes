gem 'omniauth-twitter'

http://vh.me:3000/auth/twitter/callback

in rails routes:
get "/auth/:provider/callback", to: "callbacks#index"

1.) Create a Callback Controller:
rails g controller callback --no-routes -- 
    
class CallbacksController < ApplicationController
  def index
    omniauth_data = request.env['omniauth.auth']

    user = User.find_by_omniauth(omniauth_data)
    user ||= User.create_from_omniauth(omniauth_data)

    if user.valid?
      session[:user_id] = user.id
      redirect_to root_path, notice: "Thanks for signing in with #{params[:provider].capitalize}!"
    else
      redirect_to root_path, alert: user.errors.full_messages.join(", ")
    end
  end
end


2.) rails g migration add_oauth_fields_to_user uid provider oauth_token oauth_secret oauth_raw_date:text

class AddOauthFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_secret, :string
    add_column :users, :oauth_raw_data, :text
    add_index :users, [:provider, :uid]
  end
end

3.) Update User Model: 

validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX,
    unless: :from_omniauth?

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :from_omniauth?

  serialize :oauth_raw_data

  before_create :generate_api_key

  def self.create_from_omniauth(omniauth_data)
    first_name, last_name = omniauth_data["info"]["name"].split

    User.create(
      uid: omniauth_data["uid"],
      provider: omniauth_data["provider"],
      email: omniauth_data["info"]["email"],
      first_name: first_name,
      last_name: last_name,
      oauth_token: omniauth_data["credentials"]["token"],
      oauth_secret: omniauth_data["credentials"]["secret"],
      oauth_raw_data: omniauth_data,
      password: SecureRandom.hex(32)
    )
  end

  def self.find_by_omniauth(omniauth_data)
    User.find_by(provider: omniauth_data["provider"], uid: omniauth_data["uid"])
  end
