
function fadeOut($node, time) {
    return new Promise((resolve, reject) => {
        $node.fadeOut(time, () => {
            resolve($node)
        })
        
    })
}
function fadeIn($node, time) {
    return new Promise((resolve, reject) => {
        $node.fadeIn(time, () => {
            resolve($node)
        })
    })
}

const $titleHeader = $('h1.title');
fadeOut($titleHeader, 1000)
    .then(function (node) { return fadeIn(node, 2000) })
    .then(function (node) { return fadeOut(node, 1500) })
    .then(function (node) { return fadeIn(node, 2000) })
    .then(function (node) { return fadeOut(node, 1500) })

// Promise Fade

const fadeIn = ($node, ms) => {
    return new Promise((resolve, reject) => {
        $node.fadeIn(ms, () => {
            resolve($node);
        })
    })
}

const fadeOut = ($node, ms) => {
    return new Promise((resolve, reject) => {
        $node.fadeOut(ms, () => {
            resolve($node);
        })
    })
}

/*
  The code below is equivalent to the code above but removes any code repeat!!
  all jQuery objects, like `$node` in this case, are exactly that, objects!
  for all objects, you can access properties in multiple ways
    e.g.
      let obj = {
        a: 1
      }
    obj.a === obj['a']
  if `a` was a function, then you can call it in hthe same way:
    e.g.
      let obj = {
        a: fn(){}
      }
    obj['a']() === obj.a()
  so, in the code below, `fn` is a string that represents a function property
  belonging to a jQuery node, either 'fadeIn' or 'fadeOut'
*/
function fade($node, time, fn) {
    return new Promise((resolve, reject) => {
        $node[fn](time, () => {
            resolve($node);
        })
    })
}

const fadeIn = ($node, time) => fade($node, time, 'fadeIn');
/*
  the code above is equivalent to:

  function fadeIn ($node, time) {
    return fade($node, time, 'fadeIn');
  }
*/
const fadeOut = ($node, time) => fade($node, time, 'fadeOut');