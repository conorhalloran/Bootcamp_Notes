let & const are scoped to their

function letConstScope () {
  if(true) {
    let a = 10
    let be = "Hello"
  }
  console.log(a)
  console.log(b)
}
letConstScope()

// undefined

// ***********************************************

var is scoped to its surrounding function (function scope)

function letConstScope () {
  if(true) {
    var a = 10
    var be = "Hello"
  }
  console.log(a)
  console.log(b)
}
letConstScope()

// 10 Hello
