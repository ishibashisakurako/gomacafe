// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";

import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import Raty from "raty.js"
window.raty = function(elem,opt) {
    let raty =  new Raty(elem,opt)
    raty.init();
    return raty;
}

require("trix")
require("@rails/actiontext")

document.addEventListener('DOMContentLoaded', () => {
    const loadingAreaGrey = document.querySelector('#loading');
    if (loadingAreaGrey) {
        loadingAreaGrey.animate(
            {
                opacity: [1, 0]
            },
            {
                duration: 2000,
                delay: 1200,
                easing: 'ease',
                fill: 'forwards',
            }
        );
        setTimeout(() => {
            loadingAreaGrey.style.visibility = 'hidden';
        }, 3200);
    }
});

document.addEventListener("turbolinks:load", () => {
    const items = document.querySelector('.img-item').children;
    console.log(items);
    for (let i = 0; i < items.length; i++) {
        const keyframes = {
            opacity: [0, 1]
        };
        const options = {
            duration: 900,
            delay: i * 1000,
            fill: 'forwards',
        };
        items[i].animate(keyframes, options);
    }
})