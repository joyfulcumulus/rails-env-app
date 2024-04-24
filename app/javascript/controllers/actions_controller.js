import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="actions"
export default class extends Controller {
  static values = {
    challengeEventId: Number,
    recyclableWeight: Number
  }
  static targets = ["successpopup"]

  submit(event) {
    event.preventDefault();
    const url = `/challenge_events/${this.challengeEventIdValue}/actions`
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accepts": "application/json",
        "X-CSRF-Token": this.#getMetaValue("csrf-token")
      },
      body: JSON.stringify({
        challengeEventId: this.challengeEventIdValue,
        recyclableWeight: this.recyclableWeightValue
      })
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
