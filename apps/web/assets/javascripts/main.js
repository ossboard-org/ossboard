require("!style-loader!css-loader!sass-loader!../stylesheets/tasks.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/footer.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/landing.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/main.scss");

dev_text = document.querySelector('.for-dev__developers-text');
maint_text = document.querySelector('.for-dev__maintainers-text');

document.getElementById('js-for-developers').onclick = function () {
  dev_text.classList.remove('hide');
  maint_text.classList.add('hide');
}

document.getElementById('js-for-maintainers').onclick = function () {
  dev_text.classList.add('hide');
  maint_text.classList.remove('hide');
}
