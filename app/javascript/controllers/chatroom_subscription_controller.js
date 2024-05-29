import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number, userId: Number }
  static targets = ["scroller", "messages"]

  connect() {
    this.scrollerTarget.scrollTo(0, this.messagesTarget.scrollHeight);

    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    );
    console.log(`Subscribed to chatroom of id ${this.chatroomIdValue}.`);
  }

  resetForm(event) {
    event.target.reset()

    // remove error message if there is one previously
    const errorField = document.querySelector(".is-invalid");
    if (errorField !== null) {
      errorField.classList.remove("is-invalid");
    }
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.subscription.unsubscribe()
  }

  #insertMessageAndScrollDown({sender, message}) {
    if(sender != this.userIdValue) {
      message = message.replace("message-sender", "message-receiver")
    }
    this.messagesTarget.insertAdjacentHTML("beforeend", message);
    this.scrollerTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }
}
