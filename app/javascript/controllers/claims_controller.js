import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="claims"
export default class extends Controller {
  static targets = ["userpoints", "total", "balance", "errorpopup", "successpopup", "card"]

  connect() {
    this.totalPointsUsed = 0;
    this.balancePoints = parseInt(this.userpointsTarget.innerText);
  }

  select(event) {
    const points = parseInt(event.currentTarget.dataset.points);

    if (!(event.currentTarget.classList.contains("active")) && (this.totalPointsUsed + points > this.balancePoints)) {
      this.errorpopupTarget.classList.add("active");
    } else {
      event.currentTarget.classList.toggle("active");
      if (event.currentTarget.classList.contains("active")) {
        this.totalPointsUsed += points
      } else {
        this.totalPointsUsed -= points
      }

      this.totalTarget.innerText = this.totalPointsUsed;
      this.balanceTarget.innerText = this.balancePoints - this.totalPointsUsed;
    };

  }

  close() {
    this.errorpopupTarget.classList.remove("active");
    this.successpopupTarget.classList.remove("active");
  }

  create(event) {
    event.preventDefault();
    const url = `/claims`;
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accepts": "application/json",
        "X-CSRF-Token": this.#getMetaValue("csrf-token")
      },
      body: JSON.stringify({totalPointsUsed: this.totalPointsUsed})
    })
    .then(response => response.json())
    .then(data => {
      // reset variables with the user's updated total_points
      this.totalPointsUsed = 0;
      this.balancePoints = data.newUserPoints;
      // reset display with the user's updated total_points
      this.userpointsTarget.innerText = data.newUserPoints;
      this.totalTarget.innerText = 0;
      this.balanceTarget.innerText = data.newUserPoints;
      // remove active state for voucher cards
      this.cardTargets.forEach((card) => {
        card.classList.remove("active")
      })

      // overlay with success pop up
      this.successpopupTarget.classList.add("active");
    })
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

}
