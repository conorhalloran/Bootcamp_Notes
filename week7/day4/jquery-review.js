Try Selecting:

1.) Purple Container: $('#purple-container')
2.) All Shapes: $('.shape')

Plain vs jQuery
getAttribute & setAttribute VS attr
add, remove & toggle of classList VS addClass, removeClass & toggleClass
remove VS remove

// When jQuery changes nodes, it will do that effect on all the nodes of the jQuery list without need to iterate.

// 1.) set 'href' to attributes of all links on the page to 'http://www.nyan.cat'
$('a')
$('a').attr('href', 'http://www.nyan.cat') // <-- Only the value for `href` of the first `a` is returned
// 2.) replace anything with a blue class with a red class

$('.blue')
$('.blue').removeClass('blue').addClass('red')
// Nearly all jQuery DOM manipulation methods return the jQuery list, allowing us to chain them as long as we want as shown above

// 1.) Set the class attribute of all anchors to 'highlight' with the attr attribute
$('a').addClass('highlight')
// or: 
// $('a').attr('class', 'highlight')
// 2.) Replace all 'circle' classes with 'diamond' class
$('.circle').removeClass('circle').addClass('diamond')
// 3.) Remove all shapes in the green and purple container. 
$('#green-container .shape, #purple-container .shape').remove()


Set HTML examples: Plain VS jQuery

innerHTML property      VS  html method
children property       VS  children method (can take selector arguments)
parentElement property  VS  parent method (can take selector arguments)

// EXERCISE: html, children and parent
// 1. Get 'html' of the reset button.
$('#reset').html()
// 2. Try to get 'html' of all links.
- $('a').html()
// jQuery lists come with a `map` method.But be careful because the arguments that its callback receives are not the same order as for `map` for vanilla javascript arrays.
$('a').map((value, index, array) => {
    // `value` here is actually the index
    // `index` is actually value
    // And, `array` does not exists
    console.log(value, index)
})

- $('a').map((index, value) => {
    console.log(index, value)
})
// The `value`s when mapping of a jQuery list will be nodes inside. They are regular DOM nodes. You can't use jQuery methods (like html(), addClass(), removeClas(), attr(...), etc) on them.
- $('a').map((index, value) => value.innerHTML)
// To jQuery methods one regular DOM nodes, you must wrap it with the jQuery function (i.e. $(domNode)) which will return the node inside a jQuery list allowing to use all jQuery methods on it.
- $('a').map((index, value) => $(value).html())
// 3. Change 'reset' button to read 'Launch Doggos!'
$('#reset').html('Launch Doggos!')
// 4. Replace contents of every 'td' with 'yass'
$('td').html('yass')
// 4. Select parents of all td tags 
$('td').parent()
// Use the parents(<css-query>) to search ancestor nodes 
$('tr').parents()

// Creating nodes, append & prepend
// 1.) Create a small blue diamond with a doller sign
const diamond = $(`<div class='small blue diamond shape'></div>`)
$('.container').append(diamond)
// 2.) Prepend the Nyan Cat link to the Link List
$('ul').prepend($(`<li><a href="http://www.nyan.cat">Nyan Cat</a></li>`))
// 3.) Create a div with the "container" class.
const div = $(`<div class='container'></div>`)
// 4.) Prepend it to the first section tag in the body
$('section:first-child').prepend($(div))
$('section').first().prepend($(div))
$('section').eq(0).prepend($(div))

// 4.) Append a "small black circle" to the container
const smallBlackCircle = $(`<div class='small black circle shape'></div>`)
$('section:first-child').prepend(
    $(div).append($(smallBlackCircle))
)

// EVENT LISTENERS
$('.blue.circle').on('mouseenter', event => {
    console.log('Blue Circle Go Away!')
})
$('.blue.circle').on('mouseleave', event => {
    console.log('Blue Circle Go Goodbye!')
})

$('#button-1').on('click', event => {
    $('.shape').remove()
})

