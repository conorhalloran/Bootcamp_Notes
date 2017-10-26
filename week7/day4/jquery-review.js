// Event Propogation
DOM event objects move in a predefined way throughout the DOM. They begin at the eldest ancestor (namely #document) and trickly down its children until it reaches the 'target' node. This is the CAPTURING phase. 

// Once the event reaches the 'target' node, it is in a transitionary phase, refered to as 'AT_TARGET'. Afterwards, the event bubbles up from parent to parent recursively until it reaches the eldest ancestor again. This is the BUBBLING phase and the default triggering order for event listeners. 

// Event listeners can be used to trigger during the capturing phase instead of the reverse order they trigger.

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

// event.stopPropagation() can be used to prevent an event from spreading further. This can be used during the CAPTURING or during the BUBBLING and anywhere in between. This is very useful when we have lots of listeners and we don't always want the parent node listeners to trigger. 

function eventPropogation(node) {
    const { currentTarget, eventPhase } = event;
    const { id, className, tagName } = currentTarget

    if (tagName === 'DIV' && eventPhase === 3) {
        // eventPhase can be a number from 0 - 3. Each represents which phase the event is currently at:
        // 0 == NONE (phase complete)
        // 1 == CAPTURE (capturing complete)
        // 2 == AT_TARGET (Event has reached the 'target' node and is transitioning)
        // 3 == BUBBLING (Bubbling phase)
        event.stopPropagation();
    }

    console.log(`#${tagName} - ${id} - ${className} was triggered. PHASE: ${eventPhase}`)
}

