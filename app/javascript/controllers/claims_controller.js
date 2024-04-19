import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="claims"
export default class extends Controller {
  static targets = ["userpoints", "total", "balance", "errorpopup", "successpopup"]

  static values = {
    userPoints: String
  }

  connect() {
    this.totalPointsUsed = 0;
    this.balancePoints = parseInt(this.userPointsValue);
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
      this.balanceTarget.innerText = parseInt(this.userPointsValue) - this.totalPointsUsed;
    };

  }

  close() {
    this.errorpopupTarget.classList.remove("active");
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
      console.log(data);
      this.successpopupTarget.classList.add("active");
    })
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

}
