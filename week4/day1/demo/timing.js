function runTimer(initialCount = 0) {
    let count = initialCount;
    console.log('Initial Count:', count);    
    setInterval(() => {
        count += 1;
        console.log('Current count:', count);    
    }, interval);
}