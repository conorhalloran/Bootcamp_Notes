class Queue {
    constructor() {
        this.collection = []
    }
    enqueue (value) {
        this.collection.push(value);
        return this;
    }
    dequeue (value) {
        return this.collection.shift();
    }
}