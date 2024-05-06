import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="metrics"
export default class extends Controller {
  static targets = ["participants", "recyclingRate", "volume", "waste"];

  connect() {
    // fetch params from URL (if any)
    const params = new URL(document.location.toString()).searchParams;
    const challengeId = params.get("challenge_id");
    const estateId = params.get("estate_id");
    const startDate = params.get("start_date");
    const endDate = params.get("end_date");

    if (challengeId == "" || estateId == "" || startDate == "" || endDate == "" || challengeId == null || estateId == null || startDate == null || endDate == null) {
      console.log("do nothing");
    } else {
      // compute metrics if params have been given by admin user
      // this.getParticipants();
      // this.getRecyclingRate();
      // this.getRecyclingVol();
      // this.getWasteGenerated();
    };
  }

  getParticipants() {
    const url = `/admin/users_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      // let labels1 = Object.keys(data.chartdata);
      // let data1 = Object.values(data.chartdata);

      // const participantsChart = new Chart(
      //   this.participantsTarget, // this is the canvas element where the chart will be rendered
      //   {
      //     type: 'line',
      //     options: {
      //       plugins: {
      //         legend: {
      //           display: false
      //         }
      //       }
      //     },
      //     data: {
      //       labels: labels1,
      //       datasets: [{
      //         label: 'Participants',
      //         data: data1,
      //         fill: false,
      //         borderColor: 'rgb(75, 192, 192)',
      //         tension: 0.1
      //       }]
      //     }
      //   }
      // );
    });
  }

  getRecyclingRate() {
    const url = `/admin/recycling_rate_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels2 = Object.keys(data.chartdata);
      let data2 = Object.values(data.chartdata);

      const recyclingRateChart = new Chart(
        this.recyclingRateTarget, // this is the canvas element where the chart will be rendered
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
              label: 'Rate (%)',
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

  getRecyclingVol() {
    const url = `/admin/recycling_vol_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels3 = Object.keys(data.chartdata);
      let data3 = Object.values(data.chartdata);

      const volumeChart = new Chart(
        this.volumeTarget, // this is the canvas element where the chart will be rendered
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
            labels: labels3,
            datasets: [{
              label: 'Vol (kg)',
              data: data3,
              fill: false,
              borderColor: 'rgb(75, 192, 192)',
              tension: 0.1
            }]
          }
        }
      );
    });
  }

  getWasteGenerated() {
    const url = `/admin/waste_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels4 = Object.keys(data.chartdata);
      let data4 = Object.values(data.chartdata);

      const wasteChart = new Chart(
        this.wasteTarget, // this is the canvas element where the chart will be rendered
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
            labels: labels4,
            datasets: [{
              label: 'Waste (kg)',
              data: data4,
              fill: false,
              borderColor: 'rgb(75, 192, 192)',
              tension: 0.1
            }]
          }
        }
      );
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
