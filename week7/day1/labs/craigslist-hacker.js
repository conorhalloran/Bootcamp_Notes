// Go to Vancouver's Craiglist page and hack away with JavaScript:

// - Get the href attribute of the first link on the page.
link1 = document.querySelector('a').getAttribute('href')
// - Get the number of links on this page.
let links = document.querySelectorAll('a').length
let linkCount = links.length
// - Change the text for all links to be your name.
for (let link of document.querySelectorAll('a')) {
    link.innerHTML ='<p>Conor Halloran</p>'
}

// - Make Craigslist's logo link to http://www.google.com
document.querySelector('#logo').children[0].setAttribute('href', 'http://www.google.com')
// - Make of all the text use the Papyrus font.
document.body.style.fontFamily = 'Papyrus'
// Stretch
// - Make the event calendar alternate the background colour of each day square like a chess board.
calendar = document.querySelector('.cal')

calendar.querySelectorAll('td').forEach(backgroundColor());

backgroundColor = function () {
    let i = 0
    return (elem) => {
        if (i % 2 === 0) {
            elem.style.backgroundColor = "white";
        } else {
            elem.style.backgroundColor = "grey";
        } i++;
    }
}

// - Remove all p and a nodes that contain the substring "es"
for (let a of document.querySelectorAll('a')) {
    if (a.innerHTML.contains(/es/gi)) {
        a.classList.remove()
    }
}