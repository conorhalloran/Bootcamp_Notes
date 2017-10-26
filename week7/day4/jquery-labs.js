// Practice manipulating the class attribute with the jQuery lab:

// 1.) When your mouse enters a shape, toggle the highlight class.
$('.shape').on('mouseenter', function(event) {
    $(this).addClass('highlight');
})
$('.shape').on('mouseleave', function (event) {
    $(this).removeClass('highlight');
})

// 2.) When any shape is clicked do the following:

// 3.) If the shape has the small class, hide it.
$('.shape').on('click', function (event) {
    if ($(this).hasClass('small')) {
        $(this).hide()
    }
})

// 4.) If it has the medium class, remove the medium class and add the small class.
$('.shape').on('click', function (event) {
    if ($(this).hasClass('small')) {
        $(this).hide()
    } else if ($(this).hasClass('medium')) {
        $(this).removeClass('medium').addClass('small')
    }
});
// 5.) If it has the large class, remove the large class and add the medium class.
$('.shape').on('click', function (event) {
    if ($(this).hasClass('small')) {
        $(this).hide()
    } else if ($(this).hasClass('medium')) {
        $(this).removeClass('medium').addClass('small')
    } else if ($(this).hasClass('large')) {
        $(this).removeClass('large').addClass('medium')
    }
});

// Prepend a row to the table with the columns 0 and -
const row = `<tr><td>0</td><td>-</td></tr>`
$('tbody').prepend($(row))
// - When the form's submit button is clicked, append the text input's current value to the form message.
$('input[type=submit').on('click', function (event) {

    $('form').append($('input[type=text]').val())

})

// - When Button 1 is clicked, toggle the green container.
$('#button-1').on('click', function (event) {
    $('#green-container').toggle()
})
// - When Button 2 is clicked, fade the Button Message out
$('#button-2').on('click', function (event) {
    $('#button-message').fadeOut()
})
// - When Button 3 is clicked, fade the Button Message back in.
$('#button-3').on('click', function (event) {
    $('#button-message').fadeIn()
})
// - When Button 4 is clicked, slide the green container up.
$('#button-4').on('click', function (event) {
    $('#green-container').slideUp()
})

// When the g key is pressed, toggle all gray shapes.
$(document).keydown(function (event) { 
    const { keyCode } = event;
    if (keyCode === 71) {
        $('.shape.grey').toggle()
    }
})
// When the spacebar key is pressed, append a small blue circle to the green container.
$(document).keydown(function (event) {
    const { keyCode } = event;
    if (keyCode === 71) {
        $('.shape.grey').toggle()
    } else if (keyCode === 32) {
        $('#green-container').append($(`<div class='small blue circle shape'></div>`))
    }
})
// Make the Form Message show the number of characters remaining (14 characters maximum) as you type in the text input. (e.g. "3 characters remaining").

const $formInput = $('#form-1 > input[type=text]');
$formInput.attr('maxLength', 14);

$formInput.on('input', function (event) {
    $('#form-message').html(
        `${
        14 - $(this).val().length
        } characters remaining`
    );
});

// All shapes matching the given color should be removed.
// If they enter an invalid color show them an alert message telling them, "Entered color is not a valid option!"
// Clear the input field.

$('form').submit(function (event) {
    event.preventDefault();
    let message = $('input[type=text]').val();

    if (message == 'blue' || message == 'red' || message == 'black' || message == 'grey') {
        $('.' + message + '.shape').remove()
    } else {
        alert('Entered color is not a valid option!')
    }

    $('input[type=text]').val('')
});

// When the form is submitted, clear the text in the input field.
$('#form-1' > input:first-child)
// As you type in the text input, change the Form Message to be the same as what you type.
// As you type in the text input, change the Form Message to be the REVERSE of what you type.
// Set a delegated click handler on the orange container so that red shapes are removed when you click them.