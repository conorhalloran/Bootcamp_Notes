document
console.dir(document)

1.) Selecting Nodes: 
// document.getElementById: is a method that returns the first node in the document with a given id. It is the fastest of all the various selector methods. 

getElementById: 
    let toxicTim = document.getElementById('toxic-tim');

querySelector: 
<any-Node>.querySelector </>
// querySelector is a method available on nodes that returns the first node from its descendents that matches a given CSS query. You can use any CSS selector you\'ve learned. 

    let teamAquamarineHeading = document.querySelector('.team.aquamarine').querySelector('h1')
    let teamAquamarineHeading = document
    .querySelector('.team.aquamarine')
    .querySelector('h1');


    let lastDoggoOfTeamSalmon = document.querySelector('.team.salmon .doggo:last-child')

<any-Node>.querySelectorAll </>
// querySelectorAll is a method available on nodes that returns all nodes from its descendents that match a given CSS query. 
    document.querySelectorAll('.team .doggo:nth-child(2)') // returns the 2nd row of doggos
    let allDoggos = document.querySelectorAll('.doggo') // returns all the doggos 
    let allTeams = document.querySelectorAll('.team') // returns all teams

// All nodes obtained with `querySelector` share the prototype `Node` while the object returned by `querySelectorAll` is not a `Node`. It is a `NodeList` which is an array-like (but not an `Array`) that contains all the matching nodes. You can iterate with a loop like an array. You can even `forEach` with it.

Exercise: 
1.) Select Knight Nicholas by id
    - let knightNicholas = document.getElementById('knight-nicholas')
    - let knightNicholas = document.querySelector('#knight-nicholas')
    - let knightNicholas = document.querySelectorAll('#knight-nicholas')[0]
2.) Select Moneybags Michael & Larry The Lion
    let moneyLion = document.querySelectorAll('#moneybags-michael, #larry-the-lion')
3.) Select All Team Khaki Doggos but the first
    let teamKhakiNotFirst = document.querySelectorAll('.team.khaki .doggo:not(:first-child)')
4.) Select the first doggo in every team. 
    let firstDoggos = document.querySelectorAll('.team .doggo:first-child')

// **********************************************************************************

2.) Navigating Nodes:
// Use the properties `.nextElementSibling` & `.previousElementSibling` to select the surrounding nodes of a node.
toxicTim.nextElementSibling // if toxicTim is considered 1... it'll return 2.
toxicTim.nextElementSibling.nextElementSibling // this will return 3.
document.querySelector('.team.salmon').nextElementSibling // this will return Team Aquamarine. 

// use the property '.parentElement' to grabe the parent node of a node
toxicTim.parentElement // returns roster
toxicTim.parentElement.parentElement // returns team
toxicTim.parentElement.parentElement.parentElement // returns teams

// Use the property '.children' to grab all the children nodes inside of an HTMLCollection. Their methods are slightly different. 
teamSalmon.children // returns an NTMLCollection <-- is the preferable route. 
teamSalmon.children[1].children // returns all doggos using children. 
teamSalmon.childNodes // returns a nodeList but has textNodes

// Use the '.matches' method to test whether or note a node matches a CSS query. 
toxicTim.matches('div') // returns true
toxicTim.matches('.fighter') // returns true
toxicTim.matches('p') // returns false

3.) Style Selectors
Changing inline styles:
// Nodes have a 'style' property which is an object that contains all inline styles for the node. You manually assign any CSS property that is a property of the object.

toxicTim.style
toxicTim.style.border = 'solid medium aquamarine';
toxicTim.style.transform = 'rotateZ(45deg)';
toxicTim.style.transition = '6s all'
// We assign styles this way, CSS properties compsed of multiple words must be written in camelCase instead of kebab-case
toxicTim.style.backgroundImage = 'url(image/nina_the_ninja.jpg)'
// or they can still be written in kebab-case with the bracket notation
toxicTim.style['border-top-right-radius'] = '8px'

// The .style property only returns the inline style of a node (those assigned with html attribute 'style'.) to get all styles (from stylesheets and browser defaults) of a node, use the function 'getComputedStyle'. 
getComputedStyle(toxicTim) // returns a big object containing ALL calculated styles for toxicTim. 
let toxicTimStyle = getComputedStyle(toxicTim)
toxicTimStyle.borderWidth
toxicTimStyle.borderRadius

// Use the `.innerHTML` property to get all the HTML content of node as a string.
toxicTim.innerHTML; // returns "<h1>Toxic Tim</h1>"
// Write to it to replace the HTML contents of a node.
toxicTim.innerHTML = 'PAWS';
toxicTim.innerHTML.trim()
toxicTim.innerHTML = '<h1>Inner H1</h1>'
document.body.innerHTML = ''

// Use the '.outerHTML' property to the node and its contents in HTML as text
toxicTim.outerHTML
// Write to it to replace the node entirely
toxicTim.outerHTML = '' // This replaces toxicTim with an empty text node

toxicTim.id // 'toxic-tim'
// This is very useful for input fields with their 'value' attribute to get user input. 
let nameInputField = document.querySelector('#name') // enables control of forms. 
nameInputField.value = 'carrot'

// Classes are special case. Use '.classList' property to manipulate classes. It returns an array-like object of the classes. 
toxicTim.class // undefined
toxicTim.classList

// To add a class, use the method of .add()
toxicTim.classList.add('labourer')
toxicTim.className
toxicTim.classList.add('cancer', 'tumor')

// To remove class use the 'remove' method
toxicTim.classList.remove('fighter', 'cancer', 'tumor');

toxicTim.className
toxicTim.classList.remove('labourer')

// to toggle classes
toxicTim.classList.toggle('fighter') // adds fighter class back in
toxicTim.classList.toggle('fighter') // removes fighter class

// ************************************************************

4.) Attributes 
// to reliably read and write HTML attributes, use the methods 'getAttribute' and 'setAttribute.' Unlike manipulating standard attributes with properties, these methods will work with any attribute including your own custom attributes. 
toxicTim.getAttribute('id') // returns the id
toxicTim.setAttribute('data-target', '#bumble-bertha') // adds a custom attribute, 'data-target' to the toxic-tim node.
toxicTim.setAttribute('id', 'moneybags-michael') // replaces toxicTim's id with moneybags-michael

// Use .'hasAttribute' to check wheth or not a node posses a given attribute.
toxicTim.hasAttribute('href') //false
toxicTim.hasAttribute('id') // true
toxicTim.hasAttribute('class') // true

// Use .'removeAttribute' to remove an attribute.
toxicTim.removeAttribute('id') // its gone!

// Use the '.remove' method to remove a node from the DOM. 
toxicTim.remove() // its gone
teamSalmon.remove() // they're gone!

Exercise: Vandalise the Arena
// 1.) Change the color of all teams to fushia
let allTeams = document.querySelectorAll('.team')
for (let node of document.querySelectorAll('.team') ) {
    node.style.backgroundColor = 'fushia'
}
document.querySelectorAll('.team').forEach(node => {
    node.style.backgroundColor = 'fushia'
})
// 2.) Rename all doggos to Rob the Slob
let allDoggos = document.querySelectorAll('.doggo')
document.querySelectorAll('.team .doggo').forEach(node => {
    node.innerHTML = '<h1>Rob the Slob</h1>'
})
// or  -----------------------
for (let node of document.querySelectorAll('.team .doggo')) {
    node.innerHTML = '<h1>Rob the Slob</h1>'
}

// 3.) Change all doggo pictures to that of a cat from the internet. 
document.querySelectorAll('.team .doggo').forEach(node => {
    node.style.backgroundImage = 'url(http://eskipaper.com/images/crazy-cat-1.jpg)'
})

// *************************************************************

5.) Creating Nodes:
// use 'document.createElement' to create node by giving a tag name. You must use then use everything you've learned to manipulate DOM nodes to build it fully. This will not be in the document until we add it.
const drillBitDarel = document.createElement('div')
drillBitDarel.id = 'drill-bit-darel'
drillBitDarel.classList.add('doggo', 'fighter')
drillBitDarel.innerHTML = '<h1>Drill Bit Darel</h1>'
drillBitDarel.style.backgroundImage = 'url(images/drill_bit_darel.jpg)'

// Adding nodes to the DOM
// use the .appendChild method on a parent node to add a node as the last child of that parent node. 
teamSalmon.querySelector('.roster').appendChild(drillBitDarel)
document.querySelector('.team.khaki')
    .querySelector('.roster')
    .appendChild(drillBitDarel) // this will move the node to the new team. 

teamSalmon.querySelector('.roster').prepend(drillBitDarel)

// Use `.cloneNode()` to make a copy of a node without its descendents. Use `.cloneNode(true)` to make a copy of node including all of its descendents.
toxicTim.cloneNode(true) // a deep clone to copy all children.
teamKhakiRoster = document.querySelector('.team.khaki')
    .querySelector('.roster')
teamKhakiRoster.prepend(toxicTim.cloneNode(true))