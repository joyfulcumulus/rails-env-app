import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-reward"
export default class extends Controller {
  static targets = ["addRewardForm"];

  displayForm() {
    this.addRewardFormTarget.classList.remove("d-none");
  }
}
