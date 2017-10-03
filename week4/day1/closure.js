// Functions keep a reference to the scope where they were declared. 

// let scriptLocal = "I'm global";

function foo (fooArg) {
    let fooLocal = "I'm foo";
    console.log('Inside foo:', fooLocal, fooArg);
    return function bar (barArg) {
      console.log(
        'Inside bar:', fooLocal, fooArg, barArg
      );
    };
  };
  
  // const fooBar = foo("An arg");
  // fooBar(8);