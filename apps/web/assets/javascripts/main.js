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
  template: '#modal-template',
})

var importModal = new Vue({
  el: '#import-modal',
  data: {
    showModal: false,
    hasError: false,
    errorMessage: '',
    exporingIsuue: false,
    xhr: new XMLHttpRequest()
  },
  methods: {
    exporIssue: function () {
      var url = '/api/issue?issue_url=' + document.getElementById('issueUrl').value
      var self = this
      this.exporingIsuue = true

      this.xhr.open('GET', url, true);
      this.xhr.setRequestHeader('Content-type', 'application/json');
      this.xhr.setRequestHeader('Accept', 'application/json');
      this.xhr.onload = function() {
        var data = JSON.parse(self.xhr.response)

        if (self.xhr.status == 200) {
          document.getElementById('task-title').value = data.title
          document.getElementById('task-issue-url').value = data.html_url
          document.getElementById('task-md-body').value = data.body
          self.showModal = false
        } else {
          self.hasError = true;
          self.errorMessage = 'Error: ' + data.error;
        }

        self.exporingIsuue = false
      };
      this.xhr.send();
    }
  },
  created: function () {
    document.addEventListener("keydown", (e) => {
      if (this.showModal && e.keyCode == 27) {
        this.showModal = false;
      }
    });
  }
})
