// Demo: Stack Object

function Stack() {
    this.collection = [];

}

Stack.prototype.push = function (val) {
    this.collection.push(val);
    // returning 'this' allows us to chain '.push'
    return this;
}
Stack.prototype.pop = function (val) {
    this.collection.pop(val);
    return val;
};

// The Call Stack

function callStackDemo() {
    function a () {
      console.log('This is A!');
    }
    function b () {
      a();
      console.log('This is B!');
    }
    function c () {
      b();
      console.log('This is C!');
    }
    function d () {
      c();
      console.log('This is D!');
    }
    // debugger;
    d();
  };
  