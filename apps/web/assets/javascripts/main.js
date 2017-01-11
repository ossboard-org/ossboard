import Vue from 'vue/dist/vue.js'

import "../stylesheets/main.scss";

import "script-loader!./share_buttons.js";
import "!style-loader!css-loader!../stylesheets/share_buttons.css";

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

new Vue({
  el: '#import-modal',
  data: {
    showModal: false,
    hasError: false,
    errorMessage: '',
    exportingIssue: false,
    xhr: new XMLHttpRequest()
  },
  methods: {
    exportIssue: function () {
      var url = '/api/issue?issue_url=' + document.getElementById('issueUrl').value
      var self = this
      this.exportingIssue = true

      this.xhr.open('GET', url, true);
      this.xhr.setRequestHeader('Content-type', 'application/json');
      this.xhr.setRequestHeader('Accept', 'application/json');
      this.xhr.onload = function() {
        var data = JSON.parse(self.xhr.response)

        if (self.xhr.status == 200) {
          document.getElementById('task-title').value = data.title
          document.getElementById('task-repository-name').value = data.repository_name
          document.getElementById('task-issue-url').value = data.html_url
          document.getElementById('task-md-body').value = data.body
          document.getElementById('task-lang').value = data.lang
          self.showModal = false
        } else {
          self.hasError = true;
          self.errorMessage = 'Error: ' + data.error;
        }

        self.exportingIssue = false
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

var agreementChackbox = document.getElementById("agreement-checkbox"),
    submitButton = document.getElementById("new-task-submit"),
    disableButtonReg = new RegExp('(\\s|^)pure-button-disabled(\\s|$)');

if (agreementChackbox) {
  agreementChackbox.onchange = function() {
    if (agreementChackbox.checked) {
      submitButton.className = submitButton.className.replace(disableButtonReg, ' ');
    } else {
      submitButton.className += " pure-button-disabled";
    }
  }
}

if (document.getElementById("task-body")) {
  new Vue({
    el: '#task-body',
    data: {
      write: true,
      preview: false,
      xhr: new XMLHttpRequest(),
      previewedText: document.getElementById('previewed-text'),
      taskBody: '',
      rawBody: ''
    },
    methods: {
      displayForm: function () {
        this.write = true
        this.preview = false
      },

      displayPreview: function () {
        this.write = false
        this.preview = true

        var url = '/api/md_preview'
        var self = this

        this.xhr.open('POST', url, true);
        this.xhr.setRequestHeader('Content-type', 'application/json');
        this.xhr.setRequestHeader('Accept', 'application/json');

        this.xhr.onload = function() {
          var data = JSON.parse(self.xhr.response)
          self.rawBody = data.text
        };

        this.xhr.send(JSON.stringify({md_text: this.taskBody}));
      }
    }
  })
}
