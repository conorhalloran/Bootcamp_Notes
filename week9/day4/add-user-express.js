All of today's labs build upon the Chatr Express app!

// Add the ability for messages to store user names and display

You will need to upgrade the backend to support this.It'll requires changes to models, database and routers. Don't add a User model.Simply add username string column to messages.

User names should be displayed to the left of messages
/*
function showMessage(msg) {
    return `
    <li>
    <strong>${msg.username}</strong> - ${msg.content}
    ${msg.createdAt}
    </li>
  `
}
*/
// You will need a new form field for the full name

/*
<form id="new-message">
  <input type="text" placeholder="Enter your Name" name="username">
  <textarea name="content" placeholder="Type your message..."></textarea>
  <input type="submit" value='Post Message' />
</form>

<ul id="messages"></ul>

*/

// To add columns with a Sequelize migrations, follow these instructions.

Flagging:
// <a href="javascript:void(0)></a>"
Add "Flag" feature for messages on the Chatr application.()

document.querySelectoryAll('.flag').forEach(node => {
    node.addEventListener('click', event => {
        event.preventDefault();
        alert('Flag Clicked')
    })
})

Clicking a link "flag"(or icon) should mark the message as flagged
The flag icon should indicate that a message has been flagged by changing its colour or changing its icon

/*

function flagToggle () {
    document.querySelectorAll('.flag').forEach(node => {
        node.addEventListener('click', event => {
            const { currentTarget } = event
            const messageID = currentTarget.getAttribute('data-id')
            console.log(messageID)
            currentTarget.classList.toggle('selected');
            if (currentTarget.classList.contains('selected')) {
                fetch(`/messages/${messageID}`, {
                    method: 'PATCH',
                    headers: { 'content-type': 'application/json' },
                    body: JSON.stringify({ flagged: true })
                })
            } else {
                fetch(`/messages/${messageID}`, {
                    method: 'PATCH',
                    headers: { 'content-type': 'application/json' },
                    body: JSON.stringify({ flagged: false })
                })
            }

        })
    })
}

*/
This requires changes to the routers, model & database in addition to the JS.


delete


Filtering and Sorting:
Add a button at the top of the message list to filter by flagged messages.

Clicking it will toggle the message list to only show those that were flagged.
Filter the messages being displayed only with your front - end JavaScript.It shouldn't require changes to the server.
Note: To make these work, you will need to update the Messages controller.

Stretch
Add a field to filter messages by user names.

////////////////////////////////////////////////////////////////////

Chatr Battle: 

fetch('/messages/').then((res) => res.json()).then((json) => console.log(json))
fetch('/messages/').then((res) => res.json()).then((json) => console.log(json.length))

1.) Create a new message with your first name in it, using fetch
fetch(`/messages/`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ body: '' })
})
    1.1) Update a Post:
    fetch(`/messages/68338`, {
        method: 'PATCH',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({ body: 'Duy For President' })
    }).then(() => console.log('success'))
    1.2) Delete a Post:
    fetch(`/messages/68338`, {
        method: 'Delete',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({ body: 'Duy For President' })
    }).then(() => console.log('success'))
2.) Log the bodies of all messages using fetch
fetch(`/messages/`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ body: 'Duy For President' })
})
3.) Update the messages you just created to include your last name.a
4.) Delete the message you just created.

fetch("/messages?")