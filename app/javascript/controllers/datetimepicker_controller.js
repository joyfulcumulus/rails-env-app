import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datetimepicker"
export default class extends Controller {
  connect() {
    flatpickr(this.element,
      {
        altInput: true,
        enableTime: true,
        dateFormat: "Y-m-d H:i",
      }
    )
  }
}
