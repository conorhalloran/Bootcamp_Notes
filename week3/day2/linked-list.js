// Demo: Linked Lists

// Linked List is a linear collection of elements
// Each element is a node that holds a value and points to the next value
// Singly linked list

class Node {
    constructor (value, next = null) {
        Object.assign( this, {value, next} );
        // 👆 {value, next} is a short-hand syntax for {value: value, next: next}
    }
    first () {
        return this.value;
    }
    rest () {
        return this.next;
    }
    prepend (value) {
        return new Node (value, this);  
    }
    lastNode () {
        let tracker = this;
        while (tracker.next !== null) {
            tracker = tracker.next;
        }
        return tracker;
    }
    last () {
        return this.lastNode().value;
    }
    append (value) {
        this.lastNode().next = new Node(value);
        return this; 
    }
}

let list = new Node("Last").prepend(2).prepend(1).prepend("First");