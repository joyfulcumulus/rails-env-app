import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);
// Above two lines import all necessary registerables (tree shaking)

// Connects to data-controller="metrics"
export default class extends Controller {
  static targets = ["participants", "recyclingRate", "volume", "waste", "awardPointsSpinner", "awardPointsText", "awardPointsBtn"];

  connect() {
    // fetch params from URL (if any)
    const params = new URL(document.location.toString()).searchParams;
    this.challengeId = params.get("challenge_id");
    this.estateId = params.get("estate_id");
    this.startDate = params.get("start_date");
    this.endDate = params.get("end_date");

    // check if params have been given by admin user
    const isEmptyOrNull = (value) => value === "" || value === null;
    if ([this.challengeId, this.estateId, this.startDate, this.endDate].some(isEmptyOrNull)) {
      console.log("do nothing");
    } else {
      this.getParticipants();
      this.getRecyclingVol();
      this.getWasteGenerated();
      this.getRecyclingRate();
    };
  }

  getParticipants() {
    const url = `/admin/participants_per_event?challengeId=${JSON.stringify(this.challengeId)}&estateId=${JSON.stringify(this.estateId)}&startDate=${JSON.stringify(this.startDate)}&endDate=${JSON.stringify(this.endDate)}`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels1 = Object.keys(data);
      let data1 = Object.values(data);

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
            labels: labels1,
            datasets: [{
              label: 'Participants',
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

  getRecyclingVol() {
    const url = `/admin/recycling_vol_per_event?challengeId=${JSON.stringify(this.challengeId)}&estateId=${JSON.stringify(this.estateId)}&startDate=${JSON.stringify(this.startDate)}&endDate=${JSON.stringify(this.endDate)}`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels2 = Object.keys(data);
      let data2 = Object.values(data);

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

  getWasteGenerated() {
    const url = `/admin/waste_per_event?challengeId=${JSON.stringify(this.challengeId)}&estateId=${JSON.stringify(this.estateId)}&startDate=${JSON.stringify(this.startDate)}&endDate=${JSON.stringify(this.endDate)}`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels3 = Object.keys(data);
      let data3 = Object.values(data);

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
            labels: labels3,
            datasets: [{
              label: 'Waste (kg)',
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

  getRecyclingRate() {
    const url = `/admin/recycling_rate_per_event?challengeId=${JSON.stringify(this.challengeId)}&estateId=${JSON.stringify(this.estateId)}&startDate=${JSON.stringify(this.startDate)}&endDate=${JSON.stringify(this.endDate)}`;
    fetch(url)
    .then(response => response.json())
    .then(data => {
      let labels4 = Object.keys(data);
      let data4 = Object.values(data);

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
            labels: labels4,
            datasets: [{
              label: 'Rate (%)',
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
    this.awardPointsSpinnerTarget.classList.remove("d-none");
    this.awardPointsTextTarget.innerText = "Awarding...";
    this.awardPointsBtnTarget.setAttribute("disabled", "");

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
      this.awardPointsSpinnerTarget.classList.add("d-none");
      this.awardPointsTextTarget.innerText = "Award Points";
      this.awardPointsBtnTarget.removeAttribute("disabled");
    })
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

}
