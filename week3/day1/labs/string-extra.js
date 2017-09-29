// Create an object named, StringExtras, that contain several utility methods for strings to supplant Javascript's own meager string library.

// It should have a:

// repeat method that duplicates a string n of times.
// leftPad method that adds n number of spaces to the left of a string.
// rightPad method like leftPad, but adds spaces to the right of string.
// pad method which adds n number of spaces on either side of a string.
// capitalize method which uppercases the first letter of a string.
// Example usage:

// let a = 'you';

// StringExtras.repeat(a, 3); // returns 'youyouyou'
// StringExtras.repeat(' ', 6); // returns '      '
// StringExtras.leftPad(a, 3); // returns '   you'
// StringExtras.rightPad(a, 5) + 'me'; // returns 'you     me'
// StringExtras.pad(a, 3); // returns '   you   '
// StringExtras.capitalize(a); // returns 'You'

/* ****************************************************** */
// Stretch

// Given what you've learned of prototype and this, can you think of a way to add all StringExtras methods to Javascript String's prototype?

// Modify StringExtras to act as an extension to String. You may have to do a bit of research to figure this one out.

// After your modifications, you should be able to do the following:

// Object.assign(String.prototype, StringExtras);

// let a = 'you';

// a.repeat(3); // returns 'youyouyou'
// a.leftPad(3); // returns '   you'
// a.rightPad(5) + 'me'; // returns 'you     me'
// a.pad(3); // returns '   you   '
// a.capitalize(); // returns 'You'

Object.assign (
    String.prototype, {
        repeat (n) {
            return Array(n+1).join(this);
        },
        leftPad (n) {
            return Array(n+1).join(` `) + this;
        },
        rightPad (n) {
            return this.padEnd(this.length + n);
        },
        pad (n) {
            // return Array(n+1).join(` `) + this.padEnd(this.length + n);
            return this.rightPad(n).leftPad(n);
        },
        capitalize () {
            return this.charAt(0).toUpperCase() + this.slice(1);
        }
    });
