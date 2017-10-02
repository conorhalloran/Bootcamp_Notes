// Higher order functions:

// Can be treated like any other value (base type: strings, boolean, etc)

// You must call a cunction by post-fixing () to it. 

// Using gather syntax (...x): will allow a function to take any number of arguments. It will put all arguments into a variable of the name to the right of "...".

function sum (...numbers) {
    let total = 0;
    console.log(numbers);
    for (let number of numbers) {
        total += number;
    }
    return total;
}

Can use gather to call all elements of an array to pass them through a function as arguments:
arr = [5,5,5,5];
sum(...arr) // 20

Sum accepts a variable number of arguments. This is a variadic function. Usage:
sum(8,3);
sum(9,10,3,2,4,5,2,1);

Using spread SyntaxError
// You can also use '...' when calling a function to pass all elements of an array arguments to a function. You can pass any expression as an argument to a function, including an inline array or a new object with a constructor. e.g (new Task('Do Things'))
sum(...[9,0,1,3,4])