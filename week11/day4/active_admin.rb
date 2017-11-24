27.) Add devise 
        gem 'devise'
6.) Active Admin
        26.1) gem 'activeadmin'
        26.2) bundle install
        26.3) rails generate active_admin:install
            without devise rails generate active_admin:install --skip-users

28.) Check Migrations: 
29.) 
rails g active_admin:resource question
rails g active_admin:resource user
rails g active_admin:resource event
rails g active_admin:resource membership
rails g active_admin:resource survey_answer
30.) assets/stylesheets/application.scss
    *= stub active_admin
31.) rails c 
AdminUser.create(email: 'admin@example.com', password: 'password')

in admin/questions_controller 
permit_params :title, :body, :image, {tag_ids: []}