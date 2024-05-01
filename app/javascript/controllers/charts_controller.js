import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="charts"

export default class extends Controller {
  static targets = ["points", "recyclables", "table"]
  static values = {
    challengeId: Number
  }

  connect() {
    this.getPointsHistory();
    this.getRecycledHistory();
  }

  getPointsHistory() {
    const url = `/challenges/${this.challengeIdValue}/points_history`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels1 = Object.keys(data.chartdata);
      let data1 = Object.values(data.chartdata);

      const pointsHistoryChart = new Chart(
        this.pointsTarget, // this is the canvas element where the chart will be rendered
        {
          type: 'line',
          options: {
            plugins: {
              legend: {
                display: false
              }
            }
          },
          data: {
            labels: labels1,
            datasets: [{
              label: 'Points',
              data: data1,
              fill: false,
              borderColor: 'rgb(75, 192, 192)',
              tension: 0.1
            }]
          }
        }
      );

      this.tableTarget.innerHTML = data.tabledata;
    });
  }

  getRecycledHistory() {
    const url = `/challenges/${this.challengeIdValue}/recycled_history`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels2 = Object.keys(data);
      let data2 = Object.values(data);

      const recycledHistoryChart = new Chart(
        this.recyclablesTarget, // this is the canvas element where the chart will be rendered
        {
          type: 'line',
          options: {
            plugins: {
              legend: {
                display: false
              }
            }
          },
          data: {
            labels: labels2,
            datasets: [{
              label: 'Vol (kg)',
              data: data2,
              fill: false,
              borderColor: 'rgb(75, 192, 192)',
              tension: 0.1
            }]
          }
        }
      );
    });
  }

}
