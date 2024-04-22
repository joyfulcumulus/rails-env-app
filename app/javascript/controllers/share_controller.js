import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["joinpopup", "sharepopup"]

  copyLink(event) {
    event.preventDefault()
    const currentUrl = window.location.href;
    navigator.clipboard.writeText(currentUrl)
    this.sharepopupTarget.classList.add("active");
  }

  close() {
    this.joinpopupTarget.classList.remove("active");
    this.sharepopupTarget.classList.remove("active");
  }
}
