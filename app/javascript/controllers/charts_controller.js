import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="charts"

export default class extends Controller {
  static targets = ["points", "recyclables"]
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
      let labels1 = Object.keys(data);
      let data1 = Object.values(data);

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
    });
  }

  getRecycledHistory() {
    const worldPopulationGrowth = {
      "2020": 7821000000,
      "2019": 7743000000,
      "2018": 7662000000,
      "2017": 7578000000,
      "2016": 7492000000,
      "2015": 7405000000,
    };

    let labels2 = Object.keys(worldPopulationGrowth);
    let data2 = Object.values(worldPopulationGrowth);

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
  }

}
