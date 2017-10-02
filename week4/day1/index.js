function sum (...numbers) {
    let total = 0;
    console.log(numbers);
    for (let number of numbers) {
        total += number;
    }
    return total;
}

{
    const add = ( a = 0, b = 0) => {
    return a + b;
}
}

const add = ( a = 0, b = 0) => a + b;

const flip = fn => (a, b) => fn(b, a);
