import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "form"]
  static outlets = ["execution"]

  connect() {
    this.active = this.panelTargets[0]

    document.addEventListener("turbo:submit-end", this.submitComplete.bind(this))
  }

  disconnect() {
    document.removeEventListener("turbo:submit-end", this.submitComplete.bind(this))
  }

  submitComplete(event) {
    if (event.target.dataset["panelTarget"] == "form") {
      this.executionOutlets.forEach(execution => execution.done())
    }
  }

  activate(panelId) {
    const newActive = this.panelTargets[panelId]

    if (!newActive) {
      return
    }

    this.active.classList.toggle("hidden")
    this.active = newActive
    this.active.classList.toggle("hidden")
  }

  submit() {
    const form = this.active.querySelector("form")

    if (form) {
      form.requestSubmit()
    }
  }
}
