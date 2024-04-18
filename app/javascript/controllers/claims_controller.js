import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="claims"
export default class extends Controller {
  static targets = ["total", "balance"]

  static values = {
    userPoints: String
  }

  connect() {
    this.totalPointsUsed = 0;
  }

  select(event) {
    const points = parseInt(event.currentTarget.dataset.points);

    event.currentTarget.classList.toggle("active");
    if (event.currentTarget.classList.contains("active")) {
      this.totalPointsUsed += points
    } else {
      this.totalPointsUsed -= points
    }

    this.totalTarget.innerText = this.totalPointsUsed;
    this.balanceTarget.innerText = parseInt(this.userPointsValue) - this.totalPointsUsed;

  }
}
