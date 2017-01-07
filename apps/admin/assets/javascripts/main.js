import "../stylesheets/main.scss";
import Chart from 'chart.js'

Chart.defaults.global.maintainAspectRatio = false;

window.randomScalingFactor = function() {
	return Math.round(Math.random() * 100);
}


var xhr = new XMLHttpRequest()
var url = '/api/analytics'
var analytics_data

xhr.open('GET', url, true);
xhr.setRequestHeader('Content-type', 'application/json');
xhr.setRequestHeader('Accept', 'application/json');
xhr.onload = function() {
  tasksChart(JSON.parse(xhr.response))
};
xhr.send();

function tasksChart(analytics_data) {
  var tasksChartElem = document.getElementById("tasksChart");

  var tasksChart = new Chart(tasksChartElem, {
    type: 'line',
    data: {
      labels: analytics_data.tasks.labels,
      datasets: [{
        label: "Closed",
        borderColor: 'rgba(255,99,132,1)',
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        data: [
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor()
        ],
      }, {
        label: "Submited",
        borderColor: 'rgba(54, 162, 235, 1)',
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        data: [
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor()
        ],
      }, {
        label: "In progress",
        borderColor: 'rgba(255, 206, 86, 1)',
        backgroundColor: 'rgba(255, 206, 86, 0.2)',
        data: [
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor()
        ],
      }, {
        label: "Complited",
        borderColor: 'rgba(75, 192, 192, 1)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        data: [
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor(),
          randomScalingFactor()
        ],
      }]
    },
    options: {
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
        display: true,
        text: 'Tasks on last month'
      },
    }
  });
}
