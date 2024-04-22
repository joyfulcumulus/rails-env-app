import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="challenges-footer"
export default class extends Controller {
  static targets = ["nonParticipantFooter", "participantFooter", "joinpopup", "sharepopup"]

  joinChallenge(event) {
    event.preventDefault();
    this.challengeId = event.currentTarget.dataset.challengeId
    const url = `/challenges/${this.challengeId}/join`
    fetch(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": this.#getMetaValue("csrf-token")
      }
    })
    .then(response => response.json())
    .then(() => {
      this.nonParticipantFooterTarget.classList.add("d-none");
      this.participantFooterTarget.classList.remove("d-none");
      this.joinpopupTarget.classList.add("active");
    })
  }

  copyLink(event) {
    event.preventDefault();
    const currentUrl = window.location.href;
    navigator.clipboard.writeText(currentUrl);
    this.sharepopupTarget.classList.add("active");
  }

  close() {
    this.joinpopupTarget.classList.remove("active");
    this.sharepopupTarget.classList.remove("active");
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
