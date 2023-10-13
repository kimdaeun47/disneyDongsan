$(document).on('mouseover', '.topMenu span', function() {
    $('.dept01').slideDown(400);
});
$(document).on('mouseleave', 'div', function () {
    if ($(this).hasClass('topMenu')) {
        $('.dept01').slideUp(400);
    }
});
