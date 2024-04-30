import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

// Connects to data-controller="charts"

const worldPopulationGrowth = {
  "2020": 7821000000,
  "2019": 7743000000,
  "2018": 7662000000,
  "2017": 7578000000,
  "2016": 7492000000,
  "2015": 7405000000,
  "2014": 7318000000,
  "2013": 7229000000,
  "2012": 7141000000,
  "2011": 7054000000,
  "2010": 6970000000
};

export default class extends Controller {
  static targets = ["points", "recyclables"]

  connect() {
    console.log("hello charts controller");
    const labels = Object.keys(worldPopulationGrowth);
    const data = Object.values(worldPopulationGrowth);

    const chart1 = new Chart(this.pointsTarget, { // use "this.chart" to make it instance var
      type: 'line',
      data: {
        labels,
        datasets: [{
          label: 'World Population',
          data,
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }]
      }
    });

    const chart2 = new Chart(this.recyclablesTarget, { // use "this.chart" to make it instance var
      type: 'line',
      data: {
        labels,
        datasets: [{
          label: 'World Population',
          data,
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }]
      }
    });
  }
}
