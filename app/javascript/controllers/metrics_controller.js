import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="metrics"
export default class extends Controller {
  static targets = ["participants", "recyclingRate", "volume", "waste"];

  connect() {
    this.getParticipants();
    this.getRecyclingRate();
    this.getRecyclingVol();
    this.getWasteGenerated();
  }

  getParticipants() {
    // const url = `/challenges/${this.challengeIdValue}/points_history`;
    // fetch(url)
    // .then(response => response.json())
    // .then(data => {
    //   let labels1 = Object.keys(data.chartdata);
    //   let data1 = Object.values(data.chartdata);

    //   const pointsHistoryChart = new Chart(
    //     this.pointsTarget, // this is the canvas element where the chart will be rendered
    //     {
    //       type: 'line',
    //       options: {
    //         plugins: {
    //           legend: {
    //             display: false
    //           }
    //         }
    //       },
    //       data: {
    //         labels: labels1,
    //         datasets: [{
    //           label: 'Points',
    //           data: data1,
    //           fill: false,
    //           borderColor: 'rgb(75, 192, 192)',
    //           tension: 0.1
    //         }]
    //       }
    //     }
    //   );

    //   this.tableTarget.innerHTML = data.tabledata;
    // });
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
