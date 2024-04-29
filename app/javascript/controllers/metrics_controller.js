import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="metrics"
export default class extends Controller {

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
