import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="challenges-show"
export default class extends Controller {
  static targets = ["filter", "about", "estate", "home"]

  connect() {
  }

  selectAbout(event) {
    this.filterTargets.forEach((filter) => {
      filter.classList.remove("active")
    })
    event.currentTarget.classList.add("active")

    this.aboutTarget.classList.remove("d-none")
    this.estateTarget.classList.add("d-none")
    this.homeTarget.classList.add("d-none")
  }

  selectEstate(event) {
    this.filterTargets.forEach((filter) => {
      filter.classList.remove("active")
    })
    event.currentTarget.classList.add("active")

    this.aboutTarget.classList.add("d-none")
    this.estateTarget.classList.remove("d-none")
    this.homeTarget.classList.add("d-none")
  }

  selectHome(event) {
    this.filterTargets.forEach((filter) => {
      filter.classList.remove("active")
    })
    event.currentTarget.classList.add("active")

    this.aboutTarget.classList.add("d-none")
    this.estateTarget.classList.add("d-none")
    this.homeTarget.classList.remove("d-none")
  }
}
