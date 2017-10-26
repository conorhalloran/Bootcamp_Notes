// Go to the Wikipedia page on Pugs. Open up a console, and hack away with JavaScript:

// - Change the title of the article to your name.
document.querySelector('.firstHeading').innerHTML = '<h1>Conor Halloran</h1>'
// - Hide the body of the article
document.querySelector('#bodyContent').style = 'visibility: hidden'

// - Replace the Wikipedia logo with another picture
document.querySelector('.mw-wiki-logo').style.backgroundImage = 'url(http://eskipaper.com/images/crazy-cat-1.jpg)'

Stretch
// - Replace the word "pug" in every p tag with "spud".
for (let p of document.querySelectorAll('p')) {
    p.innerHTML = p.innerHTML.replace(/pug/gi, 'spud');
}