// const character = {name: 'Jon Snow'};
// const position = {title: 'Lord Commander'};
// Object.assign(character, position);

// console.log(character) // name: Jon Snow, title: Lord Commander

// Demo Assign Objects

// Merging Multiple Objects
const bigObj = Object.assign(
    {a: 1},
    {where: 'Vancouver', thing: 'What?'},
    {thing: 'How?', b: 2, c: 3} // Which thing is going to win
);

console.log(bigObj);

// Clone an Object
const b = {a: 1, b: 2, c: 3};
const c = b // is not a copy of 'b'. Points to same memory spot. Changing b will change c. 

const d = Object.assign({}, b); // d will be a copy of b. Won't point to same memory spot. 

// Easily assign properties to a protoype. 

Counter.prototype.set = function (n) { this.count = n; };
Counter.prototype.inc = function () { this.count += this.step; return this.count; };
Counter.prototype.dec = function () { this.count -= this.step; return this.count; };

Object.assign(
    Counter.prototype, // the object below will be merged into the Counter.prototype
    {
      set (n) {
        this.count = n;
      },
      inc () {
        this.count += this.step;
        return this.count;
      },
      dec () {
        this.count -= this.step;
        return this.count;
      }
    }
  );