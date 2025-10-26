// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
import "fomantic"

$(document).on('turbo:load', function () {
    $('.ui.dropdown').dropdown();
    $('.ui.accordion').accordion();
    $('.message .close')
        .on('click', function () {
            $(this)
                .closest('.message')
                .transition('fade')
            ;
        })
    ;
});
