import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notification"]

  connect() {
    this.timeoutId = setTimeout(this.dismiss.bind(this), 10000)
  }

  disconnect() {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId)
    }
  }

  dismiss() {
    this.notificationTarget.classList.toggle("hidden")

    if (this.timeoutId) {
      clearTimeout(this.timeoutId)
      this.timeoutId = null
    }
  }
}
