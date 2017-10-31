// Any javascript you write in any of the files inside the 'app/assets/javascript' will be run in every page of your application by default

// Simply change the .coffee files to .js files. 
function query(query, node) {
    return (node || document).querySelector(query);
}
function querys(query, node) {
    return (node || document).querySelectorAll(query);
}



// $(function () {put js code here})
document.addEventListener('DOMContentLoaded', () => {
    // put JavaScript code that needs to run on the DOM inside of this function. The event 'DOMContentLoaded' will trigger when the browser has finished parsing the HTML into the DOM.
})

// $(function () {put js code here})
document.addEventListener('DOMContentLoaded', () function () {
    query('#welcome-carousel').addEventListener('click', function (event) {
        console.log('Carousel Clicked')
    })
})
var imageUrls = [
'https://i.pinimg.com/736x/72/2b/07/722b07895707baa990e9c2fe64105521--memes-funny-animal.jpg'
'http://images2.fanpop.com/images/photos/3600000/silly-puppy-animal-humor-3660987-400-405.jpg'
'https://media1.popsugar-assets.com/files/thumbor/D8uzF8v6KdHGh8R6MKDgD_mIf6s/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2013/04/15/4/192/1922243/cc80f11369b518e6_06767b0497d811e2858a22000a1f9711_7/i/Silly-Animal-Memes.jpg'
]

document.addEventListener('DOMContentLoaded', () function () {

    var welcomeCarousel = query('#welcome-carousel')
    var carouselImg = query('img', welcomeCarousel)

    welcomeCarousel.addEventListener('click', function (event) {
        carouselImg.src = imageUrls[imgIndex]
        imgIndex = (imgIndex + 1) % imageUrls.length;
        console.log('Carousel Clicked')
    })

})

// COMPLETE ***************

document.addEventListener('DOMContentLoaded', function () {

    var welcomeCarousel = query('#welcome-carousel')
    var carouselImg = query('img', welcomeCarousel)
    var imgIndex = 0;

    function nextImage() {
        carouselImg.src = imageUrls[imgIndex]
        imgIndex = (imgIndex + 1) % imageUrls.length;
    }
    welcomeCarousel.addEventListener('click', nextImage)
    setInterval(nextImage, 2000);
});