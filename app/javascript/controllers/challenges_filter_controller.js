import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="challenges-filter"
export default class extends Controller {
  static targets = ["filter", "all", "mine"]

  selectAll(event) {
    this.filterTargets.forEach((filter) => {
      filter.classList.remove("active")
    })
    event.currentTarget.classList.add("active")

    this.allTarget.classList.remove("d-none")
    this.mineTarget.classList.add("d-none")
  }

  selectMine(event) {
    this.filterTargets.forEach((filter) => {
      filter.classList.remove("active")
    })
    event.currentTarget.classList.add("active")

    this.allTarget.classList.add("d-none")
    this.mineTarget.classList.remove("d-none")
  }
}
