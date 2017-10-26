DOM - EVENTS:

CLICK, MOUSE MOVE, KEY PRESS, FORM SUBMISSION, USER INPUT, ETC.

Listen to Events: Running code when an event occurs. 
    - Prototype method of any DOM Node.Including document itself.

.addEventListener('String name of an event', A callback function() => { })
     'click', 'dbleclick', 'submit', 'input', 'mouseenter', 'mouseleave', 'keydown', 'keyup'

toxicTim.addEventListener('click', () => {
    console.log('toxicTim was clicked');
})

document.addEventListener('click', () => {
    console.log('The document was clicked!');
})

The Event Object.Contains information about the triggering event.
    document.addEventListener('click', event => {
        // EVENT OBJECT
        // The callback passed to addEventListener is called with an event object that contains information about the state of the program related to the trigger at the time it happened. 
            // - 'target' node that originally triggered the event
            // - 'currentTarget' node is the node that was used with .addEventListener
            // - 'time' the event was triggered
            // - mouse events can give you coordinates relative to the window and coordinates relative to the page
            // - for most events you can know if alt, ctrl, shift or command was held at the time for keyboard events (know which key was pressed)
        console.log('The document was clicked!');
        console.log('target:', event.target)
        console.log('currentTarget:', event.currentTarget)
    })

    // You should never use an => function inside a 'this' callback. It's scope is limited
    document.addEventListener('click', event => {
        console.log('target:', event.target)
        console.log('currentTarget:', event.currentTarget)
        console.log('this', this)
    })
    
    document.addEventListener('click', function(event) {
        console.log('target:', event.target)
        console.log('currentTarget:', event.currentTarget)
        console.log('this', this)
        // inside an addEventListener callback, 'this' is always bound to event.currentTarget. They are effectively the same. However, the 'this' of a function is not always easily predictable. It can be set before passing the function as a callback. I recommend that you use 'event.currentTarget' whenever possible. 
    })
    // GOOD!
    document.addEventListener('click', function(event) {
        console.log(this) // 'this' is event.currentTarget
    })

    // BAD!
    document.addEventListener('click', event => {
        console.log(this) // 'this' is 'window'
    })

DEMO: THE MOUSE AND DOGGO:
    'dblclick' should invert color of doggo
    document.querySelectorAll('.doggo').forEach(node => {
        node.addEventListener('dblclick', event => {
            console.log('Doggo was clicked!')
            event.currentTarget.style.filter = 'invert()';
        });
    });

in css file:
.invert {
    filter: invert();
}

document.querySelectorAll('.doggo').forEach(node => {
    node.addEventListener('dblclick', event => {
        const {currentTarget} = event
        currentTarget.classList.toggle('invert');
    });
});

// mouse down should rotate doggo 180 deg
.rotate - 180 {
    transform: rotateZ(180deg);
}

under .doggo class:
transition: 0.25s transform;
/* the `transition` property allows a node to gradually increment a css properties value over a period of time given as the first argument. The second argument is the property that will transition (`all` will work for all properties).
     https://developer.mozilla.org/en-US/docs/Web/CSS/transition
  */

node.addEventListener('mousedown', event => {
    const { currentTarget } = event;
    currentTarget.classList.add('rotate-180');
})

// `mouseup` should remove rotation
node.addEventListener('mouseup', event => {
    const { currentTarget } = event;
    currentTarget.classList.remove('rotate-180');
})

// ************** Crouching Mouse Hidden Doggo: **************
1.) Go to the Doggo Area Demo Page. 
2.) Moving the mouse inside a doggo should make it monochrome. Hint: Use a class and CSS
node.addEventListener('mouseenter', event => {
    const { currentTarget } = event;
    currentTarget.classList.add('monoChrome');
})
// .css
.monoChrome {
    filter: grayscale(100 %) contrast(100 %);
}
3.) Moving the mouse outside a doggo should reset its monochrome
node.addEventListener('mouseleave', event => {
    const { currentTarget } = event;
    currentTarget.classList.remove('monoChrome');
})

// ************** Type Loudly & Explode: **************
// TEST FIRST
document.querySelectorAll('#application-form input').forEach(node => {
    node.addEventListener('input', event => {
        console.log('Worked')
    })
})

// DEBUG: 
document.querySelectorAll('#application-form input').forEach(node => {
    node.addEventListener('input', event => {
        debugger
    })
})

// in console:
event
event.currentTarget.value

// IMPLIMENT
// putting it into a function enables the sound to be activated everytime.

const sound = new Audio('sounds/dog-bark-1.wav')
sound.play()

const playKey = () => new Audio('sounds/vintage-keyboard-1.wav')

document.querySelectorAll('#application-form input').forEach(node => {
    node.addEventListener('input', event => {
        console.log('value of input:', event.currentTarget.value);
        playKey().play();
    });
})

// Works:

const random = n => Math.ceil(Math.random() * n);
const playKey = () => new Audio(`sounds/vintage-keyboard-${random(5)}.wav`);

document.querySelectorAll('#application-form input').forEach(node => {
    node.addEventListener('input', event => {
        console.log('value of input:', event.currentTarget.value);
        playKey().play();
    });
})

document
    .querySelector('#application-form')
    .addEventListener('submit', event => {
        // To prevent a 'form' from doing a web request (its default behaviour), use the '.preventDefault()' method on the event.
        event.preventDefault();
        console.log('Form is submitted')
        // How do we grab all the values of its descendent input fields?
        const { currentTarget } = event;
        const formValues = {};
        // We can grab all of the input fields and put their name attribute and value attribute in an object... 
        currentTarget.querySelectorAll('input').forEach(input => {
            formValues[input.name] = input.value;
        })
        console.log(formValues)
        // Or:
        // We can use the FormData constructor
        // We can use the FormData constructor
        window.fData = new FormData(currentTarget);
        // In Chrome, the form data object always displays like so FormData {} as if
        // its empty. Do not be deceived by that. If you put `name` attributes on
        // your input fields, it should not be empty.

        // Get values from the FormData object with .get and set them with .set.
        fData.get('name') // Will get the value of the input field with the name `name`
        fData.get('team-name') // Will get the value of the input field with the name `team-name`

        fData.set('color', 'pink')
        // Adds a new entry to the form data object with the name `color` and the
        // value `pink`

        // To get all values from the form data object, use the following:
        Array.from(fData.values())
        // ... all keys:
        Array.from(fData.keys())
        // ... everything:
        Array.from(fData.entries())
    })

    
console:
fData // returns FormData {}
fData.get('name') // returns value of 'name'
Array.from(fData.values())
Array.from(fData.keys())

document
    .querySelector('#application-form')
    .addEventListener('submit', event => {
        event.preventDefault()
        const formNode = event.currentTarget;
        
        const fData = new FormData(formNode)
        const pictureUrl = fData.get('picture-url')
        console.log(pictureUrl)
        const blankDoggo = document.querySelector('#applicant-preview .doggo.blank');
        blankDoggo.style.backgroundImage = `url(${pictureUrl})`;
    })

http://media.veryfunnypics.eu/2016/05/funny-pictures-whos-a-good-boy.jpg

// ************** Keyboard Events (Shortcuts): **************

// test
document.addEventListener('keydown', event => {
    console.log(event);
})

// edit
document.addEventListener('keydown', event => {
    const { altKey, ctrlKey, shiftKey, metaKey, key, keyCode } = event;
    console.log({ altKey, ctrlKey, shiftKey, keyCode });

    if (ctrlKey && altKey && keyCode === 78) {
        console.log('Going to nyan.cat!');
        window.location.href = 'http:www.nyan.cat'
    }
});

// Exercise Shortcut Ninja
let panicCombo = ''

// BEST
document.addEventListener('keydown', event => {
    const { altKey, ctrlKey, shiftKey, metaKey, key, keyCode } = event;
    if (key.length > 1) return
    panicCombo = (panicCombo + key.toLowerCase()).slice(-5);
    console.log(panicCombo);
    if (panicCombo === 'panic') {
        window.location.href = 'http:hackertyper.net'
    }
})

// GOOD
document.addEventListener('keydown', event => {
    const { altKey, ctrlKey, shiftKey, metaKey, key, keyCode } = event;
    if (key.length > 1) return
    panicCombo = (panicCombo + key.toLowerCase()).slice(-5);
    console.log(panicCombo);
    if (panicCombo.includes('panic')) {
        window.location.href = 'http:hackertyper.net'
    }
})

// ************** Event Propogation **************
DOM event objects move in a predefined way throughout the DOM.They begin at the eldest ancestor (namely #document) and trickly down its children until it reaches the 'target' node.This is the CAPTURING phase.

    // Once the event reaches the 'target' node, it is in a transitionary phase, refered to as 'AT_TARGET'. Afterwards, the event bubbles up from parent to parent recursively until it reaches the eldest ancestor again. This is the BUBBLING phase and the default triggering order for event listeners. 

    document.querySelectorAll('.doggo, .roster, .team, .teams, body').forEach(
    node => {
        node.addEventListener('click', event => {
            const { currentTarget } = event;
            const { id, className, tagName } = currentTarget
            console.log(`#${tagName} - ${id} - ${className} was triggered`)

        }, true) // adding true will change the order in which the nodes are triggered. 

    }
    )

// Can consoildate to:
function eventPropogation(node) {
    const { currentTarget, eventPhase } = event;
    const { id, className, tagName } = currentTarget
    console.log(`#${tagName} - ${id} - ${className} was triggered. PHASE: ${eventPhase}`)
}

document.querySelectorAll('.doggo, .roster, .team, .teams, body').forEach(
    node => {
        node.addEventListener('click', eventPropogation, true)
        node.addEventListener('click', eventPropogation)
    }
)
