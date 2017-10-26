// It's best to start with a fresh clone of Doggo Arena for the labs.

// Implement the ability to select doggos
function unselectAllDoggos() {
    document.querySelectorAll('.doggo.fighter').forEach(function (selected) {
        selected.classList.remove('selected');
    })
}

function findSelected() {
    return document.querySelector('.doggo.fighter.selected')
}

// Clicking a .doggo.fighter adds the selected class to it. A doggo with the selected class is considered selected.
document.querySelectorAll('.doggo.fighter').forEach(node => {
    node.addEventListener('click', event => {
        const { currentTarget } = event
        currentTarget.classList.toggle('selected');
    })
})

// Only one doggo should can have the selected class.
document.querySelectorAll('.doggo.fighter').forEach(node => {
    node.addEventListener('click', event => {

        const { currentTarget } = event
        unselectAllDoggos()
        currentTarget.classList.toggle('selected');
    })
})

// Give a select .doggo.fighter a bright green boarder
.doggo.fighter.selected {
    border: solid 5px rgb(32, 238, 49);
}
// Clicking a team's name, moves the selected doggo to that team.
document.querySelectorAll('.team .title').forEach(node => {
    node.addEventListener('click', event => {
        const target = node.parentNode.querySelector('.roster')
        selectedDoggo = findSelected()
        target.appendChild(selectedDoggo);
    })
})

// Stretch
// Clicking anywhere else on the page, unselects all selected .doggo.fighters.
document.querySelector('body').addEventListener('click', function (event) {
    const dog = event.currentTarget;
    if (dog && !dog.classList.contains('doggo') && !dog.classList.contains('fighter')) {
        unselectAllDoggos();
    }
});

// ************ RECRUIT FIGHTER ************
// Update the applicant preview's h1 node contents with the applicant name as it is typed.
// Note: input as oppose to keydown searches for a change
document
    .querySelector('#application-form')
    .addEventListener('input', event => {
        const formNode = event.currentTarget;
        const { altKey, ctrlKey, shiftKey, metaKey, key, keyCode } = event;
        const fData = new FormData(formNode)
        let doggoName = fData.get('name')
        const blankDoggo = document.querySelector('#applicant-preview .doggo.blank');
        blankDoggo.innerHTML = `<h1>${doggoName}</h1>`
    })
// Update the applicant preview's picture once a valid picture url as it is typed. Check that the typed in field ends with .jpg, .gif or .png.

function validPicture (url) {
    if (url.includes('.jpg') || url.includes('.png') || url.includes('.gif') || url.includes('.jpeg')) {
        return true
        } else {
        return false
        }
}

document
    .querySelector('#application-form')
    .addEventListener('submit', event => {
        event.preventDefault()
        const formNode = event.currentTarget;
        const fData = new FormData(formNode)
        const pictureUrl = fData.get('picture-url')
        if (validPicture(pictureUrl) === true) {
            const blankDoggo = document.querySelector('#applicant-preview .doggo.blank');
            blankDoggo.style.backgroundImage = `url(${pictureUrl})`;
        } else {
            alert('Please enter a valid image url (contains: .jpg, .png, .gif, .jpeg)')
        }
    })

// Give a salmon, aquamarine or khaki border to the applicant preview depending on which team as it is typed.

function validName(value) {
    return value.length != 0;
}

function validTeamName(name) {
    const teamNames = ['salmon', 'khaki', 'aquamarine'];
    return teamNames.includes(name);
}

function updateTeam(value) {
    const lowercaseTeamName = value.toLowerCase();
    if (validTeamName(lowercaseTeamName)) {
        const preview = document.querySelector('#applicant-preview');
        preview.style.borderColor = `${lowercaseTeamName}`;
    }
}

//     Stretch
// When the form is submitted, reset the applicant preview and create that .doggo.fighter in the team written in the team name field.

// ************* USER FRIENDLY SHORT CUTS *************

// Holding ctrl and pressing a number selects the .doggo.fighter at that index. .team.salmon doggo's should be first. This should work even if new .doggo.fighters are added to the team (e.g. Pressing ctrl-0 selects #toxic-tim, pressing ctrl-4 selects #larry-the-lion, etc)

// backspace removes a selected .doggo.fighter from the DOM.

// Stretch
// With a .doggo.fighter selected, holding ctrl and pressing right arrow moves a .doggo.fighter to the team on their right; pressing ctrl + left arrow, moves selected .doggo.fighter to the team on their left.This unselects the selected doggo in the process.