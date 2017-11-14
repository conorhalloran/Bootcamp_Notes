Steps to Implimenting Mailers into your App:

1.) rails g mailer products_mailer
    rails g mailer reviews_mailer
2.) config/initializer/ - create file: setup_mail.rb
    2.1) ActionMailer::Base.smtp_settings = {
            address: 'smtp.gmail.com',
            port: '587',
            enable_starttls_auto: true,
            authentication: :plain,
            user_name: ENV['EMAIL_USER_NAME'],
            password: ENV['EMAIL_PASSWORD']
        }   
3.) enter git ignore: /config/initializers/app_keys.rb
4.) create file: app_keys.rb
    ENV['EMAIL_USER_NAME'] = 'answerawesome'
    ENV['EMAIL_PASSWORD'] = 'Sup3r$ecret$$'
    4.1) create file: app_keys_duplicate.rb
        ENV['EMAIL_USER_NAME'] = 'PUT EMAIL USERNAME HERE'
        ENV['EMAIL_PASSWORD'] = 'PUT EMAIL PASSWORD HERE'
5.) Defining Mailer Methods:
        5.1) app/mailers/products_mailer.rb
        class ProductsMailer < ApplicationMailer

            def notify_product_owner(product)
                @product = product
                @owner = product.user
                mail(to: @owner.email, subject: "You created a new product!")
            end

        end

6.) Establish an email template app/views/products_mailer: notify_product_owner.html.erb and notify_product_owner.text.erb
        6.1) notify_product_owner.html.erb
            <p>Hello <%= @owner.full_name %>,</p>
            <p>You Created a new Product.</p>
            <p>Product title: <%= @product.title %></p>
            <p>Description: <%= @product.description %></p>
            <p>Price: <%= @product.price %></p>
            <p>Sale Price: <%= @product.sale_price %></p>
            <%= link_to 'Click Here to View the Product', product_url(@product) %>
            <p>Regards,</p>
            <p>Amazon Clone Team</p>
        6.2) notify_product_owner.text.erb
            Hello <%= @owner.full_name %>,
            You Created a new Product.
            Product title: <%= @product.title %>
            Description: <%= @product.description %>
            Price: <%= @product.price %>
            Sale Price: <%= @product.sale_price %>
            <%= link_to 'Click Here to View the Product', product_url(@product) %>
            Regards,
            Amazon Clone Team

7.) Sending Emails 
    7.2) Install Gems:
        gem "letter_opener" => group development do 
    7.1) Add localhost to config/environments/development.rb:
            config.action_mailer.delivery_method = :letter_opener
            config.action_mailer.default_url_options = { host: "localhost:3000" }
    7.2) Add to Products Controller:
    if @product.save
        ProductsMailer.notify_product_owner(@product).deliver_now
8.) Delayed Jobs:
    gem 'delayed_job_active_record'
    gem 'delayed_job_web'
    rails g delayed_job:active_record
    rails db:migrate

    8.1) config/application.rb: under module AmazonClone: config.active_job.queue_adapter = :delayed_job
    8.2) Update routes.rb: match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
    8.3) Generate Jobs: 
        rails jobs:work
        rails g job product_reminders
    8.4) Products Controller:
    if @product.save
        ProductRemindersJob.set(wait_until: 5.days.from_now).perform_later(@product.id)


9.) Reviews Created:
    ProductsMailer.notify_product_owner(@review).deliver_later