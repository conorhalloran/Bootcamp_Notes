1.) Views/Questions/Show.html.erb: add remote: true to form
=begin 
<%= form_for [@question, @answer], remote: true do |f| %>
  <% if @answer.errors.present? %>
    <p>
      <%= @answer.errors.full_messages.join(', ') %>
    </p>
  <% end %>
  <div>
    <%= f.text_area :body %>
  </div>
  <%= f.submit %>
<% end %>
=end
2.) In Questions Controller -> def create :
    respond_to do |format|
        if @question.save
            ...
            format.html { redirect_to question_path(@question) }
            format.js   { render } # this will render questions/create.js.erb
            # redirect_to @question #ð when given a model instance, shortcut for ð
        end
    end
3.) In Awnswer Controller -> def create : 
    respond_to do |format|
        if @answer.save
            @question.answer!
            AnswersMailer.notify_question_owner(@answer).deliver_later
            format.html { redirect_to question_path(@question) }
            format.js   { render } # this will render answers/create.js.erb
        else
        end
    end
4.) In Views/Answers/ create: create.js.erb
$('.answer-list').prepend("<%= @answer.body %>")
    4.1.) rename answer.html.erb to _answer.html.erb
5.) In Views/Questions show.html.erb:
=begin 
<div class="answer-list">
  <% @answers.each do |answer| %>
    <%= render '/answers/answer', answer: answer %>
  <% end %>
  <%#= render @answers %>
</div>
=end
6.) Update create.js.erb
$('.answer-list').prepend("<%= j render '/answers/answer', answer: @answer %>");

############## ERROR HANDLING!! ################
1.) In Views/Answers create : _form.html.erb
Copy the from from Question.Show.erb:
=begin
<%= form_for [@question, @answer], remote: true do |f| %>
  <% if @answer.errors.present? %>
    <p>
      <%= @answer.errors.full_messages.join(', ') %>
    </p>
  <% end %>
  <div>
    <%= f.text_area :body %>
  </div>
  <%= f.submit %>
<% end %>
=end
2.) In Views/Questions/show.html.erb 
# <%= render '/answers/form' %> 
3.) Update create.js.erb file: 
=begin

<% if @answer.errors.any? %>
    $('#new_answer').replaceWith("<%= j render '/answers/form' %>")
<% else %>
    $('.answer-list').prepend("<%= j render '/answers/answer', answer: @answer %>");
<% end %>

=end 
4.) Add to Answer Controller ->def create -> else section:
    format.html { render 'questions/show' }
    format.js   { render }
5.) Update create.js.erb file: 
=begin
<%# we need to reset @answer before rendering the form because at this point
      @answer refers to the persisted answer we just created in the database so
      the form will submit to the `update` action instead of the `create` action
      unless we reset `@answer` to become `Answer.new`
      %>
  <% @answer = Answer.new %>
  $('#new_answer').replaceWith("<%= j render '/answers/form' %>");
=end
6.) Delete Answer: In Views/Answer/_answer.html.erb
=begin 

<% if can?(:destroy, answer) %>
    <%= link_to(
      'Delete',
      answer_path(answer),
      data: {confirm: 'Are you sure?'},
      method: :delete,
      remote: true
    ) %>

=end
7.) In Awnswer Controller -> def destroy 
def destroy
    @answer.destroy
    respond_to do |format|
        format.html { redirect_to question_path(@answer.question) }
        format.js   { render } # this will render /answers/destroy.js.erb
    end
end
8.) In Views/Answer/_answer.html.erb
#  <div class="answer-list-item" id="<%= dom_id(answer) %>">
9.) In Views/Answer create destroy.html.erb 
# $("#<%= dom_id(@answer) %>").fadeOut(800, () => { $(this).remove() });
