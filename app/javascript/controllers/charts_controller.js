import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="charts"

const worldPopulationGrowth = {
  "2020": 7821000000,
  "2019": 7743000000,
  "2018": 7662000000,
  "2017": 7578000000,
  "2016": 7492000000,
  "2015": 7405000000,
};

export default class extends Controller {
  static targets = ["points", "recyclables"]
  static values = {
    challengeId: Number
  }

  connect() {
    const labels = Object.keys(worldPopulationGrowth);
    const data = Object.values(worldPopulationGrowth);

    const chart1 = new Chart(
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
          labels,
          datasets: [{
            label: 'Points',
            data,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          }]
        }
      }
    );

    const chart2 = new Chart(
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
          labels,
          datasets: [{
            label: 'Vol (kg)',
            data,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          }]
        }
      }
    );

  }

  getPointsHistory(event) {
    event.preventDefault();
    const url = `/challenges/${this.challengeIdValue}/points_history`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log(data);
    })
  }

}
