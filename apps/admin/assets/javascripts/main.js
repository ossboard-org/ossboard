import "../stylesheets/main.scss";
import Chart from 'chart.js'

Chart.defaults.global.maintainAspectRatio = false;

var xhr = new XMLHttpRequest()
var url = '/api/analytics'
var analytics_data

xhr.open('GET', url, true);
xhr.setRequestHeader('Content-type', 'application/json');
xhr.setRequestHeader('Accept', 'application/json');
xhr.onload = function() {
  var data = JSON.parse(xhr.response)
  tasksChart(data)
  usersChart(data)
};
xhr.send();

function tasksChart(analytics_data) {
  var tasksChartElem = document.getElementById("tasksChart");

  new Chart(tasksChartElem, {
    type: 'line',
    data: {
      labels: analytics_data.labels,
      datasets: [{
        label: "Closed",
        borderColor: 'rgba(255,99,132,1)',
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        data: analytics_data.tasks.in_progress,
      }, {
        label: "Assigned",
        borderColor: 'rgba(54, 162, 235, 1)',
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        data: analytics_data.tasks.assigned,
      }, {
        label: "In progress",
        borderColor: 'rgba(255, 206, 86, 1)',
        backgroundColor: 'rgba(255, 206, 86, 0.2)',
        data: analytics_data.tasks.closed,
      }, {
        label: "Complited",
        borderColor: 'rgba(75, 192, 192, 1)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        data: analytics_data.tasks.done,
      }]
    },
    options: chartsOptions()
  });
}

function usersChart(analytics_data) {
  var usersChartElem = document.getElementById("usersChart");

  new Chart(usersChartElem, {
    type: 'line',
    data: {
      labels: analytics_data.labels,
      datasets: [{
        label: "Users",
        borderColor: 'rgba(255,99,132,1)',
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        data: analytics_data.users
      }]
    },
    options: chartsOptions()
  });
}

function chartsOptions() {
  return {
    legend: {
      position: 'bottom',
    },
    hover: {
      mode: 'index'
    },
    scales: {
      xAxes: [{
        display: true,
        scaleLabel: {
          display: true,
          labelString: 'days'
        }
      }],
      yAxes: [{
        display: true,
        scaleLabel: {
          display: true,
          labelString: 'count'
        }
      }]
    },
    title: {
      display: false
    },
  }
}
