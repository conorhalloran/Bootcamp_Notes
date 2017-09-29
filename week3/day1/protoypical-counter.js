// When declaring arguments, use the assignment operator '=' to declare defaults. If the counter is called as a constructor or not without arguments, count and step will be set to 0 and 1 respectively. 

  function Counter (count = 0, step = 1) {
    //   Any property that should unique to an instance of constructor must be declared here (instead of the prototype).
      this.count = count;
      this.step = step;
  }

  Counter.prototype.set = function (n) { this.count = n; };
  Counter.prototype.inc = function () { this.count += this.step; return this.count; };
  Counter.prototype.dec = function () { this.count -= this.step; return this.count; };
  Counter.prototype.now = function () { return this.count; };
  Counter.prototype.now = function () { return this.count; };
  Counter.prototype.setStep = function (n) { this.step = n; };
  Counter.prototype.reset = function () { this.count = 0; };