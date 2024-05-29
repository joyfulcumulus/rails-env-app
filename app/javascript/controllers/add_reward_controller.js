import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-reward"
export default class extends Controller {
  static targets = ["addRewardSection", "addRewardForm", "rewardsList"];

  displayForm() {
    this.addRewardSectionTarget.classList.remove("d-none");
  }

  send(event) {
    event.preventDefault();
    const challengeId = event.target.dataset.challengeId;
    const formData = new FormData(this.addRewardFormTarget);
    formData.append('challengeId', challengeId);

    fetch(this.addRewardFormTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.inserted_reward) {
        this.rewardsListTarget.insertAdjacentHTML("beforeend", data.inserted_reward);
      }
      this.addRewardFormTarget.reset();
    }
    )
  }
}
