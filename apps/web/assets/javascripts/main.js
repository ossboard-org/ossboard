require("!style-loader!css-loader!sass-loader!../stylesheets/user.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/modal.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/syntax.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/static.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/tasks.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/footer.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/landing.scss");
require("!style-loader!css-loader!sass-loader!../stylesheets/main.scss");

require("script-loader!./share_buttons.js");
require("!style-loader!css-loader!../stylesheets/share_buttons.css");

window.onload = function () {
  var taskTitleTag = document.getElementById('task_title');
  var taskTitle = taskTitleTag.textContent || taskTitleTag.innerText;
  var config = {
    networks: {
      googlePlus: {
        enabled: true,
      },
      twitter: {
        enabled: true,
        description: taskTitle
      },
      facebook: {
        enabled: true,
        loadSdk: true,
        title: taskTitle
      },
      reddit: {
        enabled: true,
        title: taskTitle
      },
      email: {
        enabled: true,
        description: taskTitle
      }
    }
  }
  var share = new ShareButton('.task__share', config);
}

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


Vue.component('modal', {
  template: '#modal-template'
})

var importModal = new Vue({
  el: '#import-modal',
  data: {
    showModal: false
  },
})
