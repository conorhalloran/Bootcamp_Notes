JSON: Lightweight format from transmitting data.
    - Based on a subset of Javascript
    - No Comments in JSON. 

Live Chat with AJAX:
    - Chatr 
    - Setting up App:
        git clone https://github.com/CodeCoreYVR/chatr-express.git
        nvm install 8.5.0
        npm install -g yarn
        cd chatr-express 
        yarn 
        yarn db:setup
        npm run start
    Write your client-side JavaScript in public/javascripts/main.js

Open inspector -> console.
fetch("/messages").then((res) => res.json()).then((json) => console.log(json))
1.) Add the ability to list all the messages from the server to the Chatr Application
function createMessage(msg) {
    return `
    <li>
      ${msg.content}
      ${msg.createdAt}
    </li>
  `
}

fetch("/messages").
    then((res) => res.json()).
    then((json) => {
        const msgsDiv = document.getElementById('messages');
        let msgs = '';
        for (let msg of json) {
            msgs += createMessage(msg);
        }
        msgsDiv.innerHTML = msgs;
});

2.) Add the ability to refresh the list of messages every 1 second. 

function oneSecRefresh () {

    fetch("/messages").
    then((res) => res.json()).
    then((json) => {
        const msgsDiv = document.querySelector('#messages');
        let msgs = '';
        for (let msg of json) {
            msgs += createMessage(msg);
        }
        msgsDiv.innerHTML = msgs;
    });
}

setInterval(oneSecRefresh, 1000)
oneSecRefresh()

3.) Add the Ability to Post a Chat Message to the server Using the Form:
