require("!style-loader!css-loader!sass-loader!../stylesheets/syntax.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/static.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/tasks.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/footer.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/landing.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/main.scss");

import Vue from 'vue/dist/vue.js'

var for_dev = new Vue({
  el: '#for-dev',
  data: {
    forDevelopers: true,
    forMaintainers: false
  },
  methods: {
    displayForDevelopers: function () {
      this.forDevelopers = true
      this.forMaintainers = false
    },

    displayForMaintainers: function () {
      this.forDevelopers = false
      this.forMaintainers = true
    }
  }
})
