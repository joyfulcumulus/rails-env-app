import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

// Connects to data-controller="metrics"

const worldPopulation = {
  "men": 30,
  "women": 70
};

export default class extends Controller {
  static targets = ["donut"];

  connect() {
    console.log("hello metrics controller");
    const labels = Object.keys(worldPopulation);
    const data = Object.values(worldPopulation);

    const chart = new Chart(this.donutTarget, { // use "this.chart" to make it instance var
      type: 'doughnut',
      data: {
        labels,
        datasets: [{
          label: 'Gender Ratio',
          data,
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
            'rgb(255, 205, 86)'
          ],
          hoverOffset: 4
        }]
      }
    });
  }


  awardPoints(event) {
    event.preventDefault();
    const url = `/admin/award_points`;
    fetch(url, {
      method: "POST",
      headers: {
        "Accepts": "application/json",
        "X-CSRF-Token": this.#getMetaValue("csrf-token")
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
    })
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

}
