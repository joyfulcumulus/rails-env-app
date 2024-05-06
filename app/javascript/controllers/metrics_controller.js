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
    const url = `/admin/users_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels = Object.keys(data.chartdata);
      let data = Object.values(data.chartdata);

      const participantsChart = new Chart(
        this.participantsTarget, // this is the canvas element where the chart will be rendered
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
            labels: labels,
            datasets: [{
              label: 'Participants',
              data: data,
              fill: false,
              borderColor: 'rgb(75, 192, 192)',
              tension: 0.1
            }]
          }
        }
      );
    });
  }

  getRecyclingRate() {
    const url = `/admin/recycling_rate_per_event`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels = Object.keys(data.chartdata);
      let data = Object.values(data.chartdata);

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
            labels: labels,
            datasets: [{
              label: 'Rate (%)',
              data: data,
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
      let labels = Object.keys(data.chartdata);
      let data = Object.values(data.chartdata);

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
            labels: labels,
            datasets: [{
              label: 'Vol (kg)',
              data: data,
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
      let labels = Object.keys(data.chartdata);
      let data = Object.values(data.chartdata);

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
            labels: labels,
            datasets: [{
              label: 'Waste (kg)',
              data: data,
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
