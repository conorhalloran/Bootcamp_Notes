fetch(polyfill):
https://github.com/github/fetch

const BASE_URL = 'http://localhost:3000';
const API_KEY = 'axgV1SHtk0EMjFjxcs3ZLwGjLWEb-2JlvDOHAsCNNhqIZ8cI3qEYvUR4DaFLJE9fUFVWBpidw06nVwvqxvhHSw';

document.addEventListener('DOMContentLoaded', (event) => {
    fetch(`${BASE_URL}/api/v1/questions`, {
        headers: { 'api_key': API_KEY }
    }).then((res) => res.json()).then((json) => {
        let html = ''
        json.questions.forEach((question) => {
            html += generateQuestionHTML(question);
        });
        document.querySelector('#questions').innerHTML = html
    });

    function generateQuestionHTML(question) {
        return `
    <div>
    <strong>${question.title}</strong>
    <a href='javascript:void(0);' class='question'>Show More</a>
    <hr>
    </div>`
    }
})

Rails Applications to Allow COAO: Cross Origin Allow Origin
https://github.com/cyu/rack-cors
gem 'rack-cors'

Add to config/application.rb:
/* 
    config.middleware.insert_before 0, Rack:: Cors do
        allow do
        origins '*'
            resource '*', : headers => : any, : methods => [: get, : post, : options]
        end
    end

