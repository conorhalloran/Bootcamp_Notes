Simple Form: https://github.com/plataformatec/simple_form
gem 'simple_form'

Integrate Simple Form with Bootstrap:
rails generate simple_form:install --bootstrap

go to your _form.html.erb file in views folder:
1.) change: # <%= form_for @question do |form| %>
2.) to: # <%= simple_form_for @question do |form| %>
3.) remove entire form: 
=begin

<% if @question.errors.present? %>
        <p>
            <%= @question.errors.full_messages.join(', ') %>
        </p>
    <% end %>
    
=end
4.) replace with:
=begin

    <%= simple_form_for @question do |form| %>
        <%= form.input :title %>
        <%= form.input :body %>
        <%= form.association :tags, input_html: { class: 'chosen-select' } %>
        <%= form.submit class: 'btn btn-primary' %>
    <% end %>

=end