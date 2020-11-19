const Turbolinks = require('turbolinks');
const Slideout = require('slideout');

if (Turbolinks.supported) {
  Turbolinks.start();
  Turbolinks.setProgressBarDelay(0);
}

document.addEventListener('turbolinks:load', () => {
  var html = document.getElementsByTagName('html')[0];
  if (html.classList.contains('slideout-open')) {
    html.classList.remove('slideout-open');
  }
  
  panel = document.getElementById('panel');
  if (panel == undefined) {
    return;
  }

  if (panel.classList.contains('slideout-panel')) {
    return;
  }

  const menu = document.getElementById('slider-menu');
  if (menu == undefined) {
    return;
  }

  var slideout = new Slideout({
    panel: panel,
    menu: menu,
    padding: 0,
    touch: false,
  });

  document.querySelector(".toggle-button").addEventListener("click", () => {
    slideout.toggle();
  });

  document.getElementById("slider-menu").addEventListener("click", (event) => {
    if (event.target.nodeName === "A") {
      slideout.toggle();
    }
  });
});
