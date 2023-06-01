import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use";

export default class extends Controller {
  static targets = ["modal", "container", "frame", "form", "submit"]
  static outlets = ["backdrop"]

  connect() {
    useTransition(this, { element: this.modalTarget })

    this.timeouts = []

    addEventListener("turbo:submit-end", this.submitResult.bind(this))
  }

  disconnect() {
    this.clearTimeouts()
    removeEventListener("turbo:submit-end", this.submitResult.bind(this))
  }

  open(event) {
    event.preventDefault()

    this.configureModal(event.target)

    this.toggleBackdrop()
    this.toggleTransition()
  }

  close(event) {
    event.preventDefault()

    this.clearTimeouts()

    this.toggleTransition()
    this.toggleBackdrop()


    this.timeouts.push(
      setTimeout(() => this.restoreModal(), 500)
    )
  }

  configureModal(target) {
    const url = target.getAttribute("href")
    const label = target.dataset["submit-label"]

    this.submitTarget.innerText = label
    this.frameTarget.setAttribute("src", url)

    this.containerTarget.classList.toggle("hidden")
  }

  restoreModal() {
    this.containerTarget.classList.toggle("hidden")

    this.submitTarget.innerText = ""
    this.submitTarget.removeAttribute("disabled")
    this.frameTarget.setAttribute("src", "")
  }

  submit(event) {
    event.preventDefault()

    if (!this.hasFormTarget) {
      return
    }

    this.submitTarget.setAttribute("disabled", "true")
    this.formTarget.requestSubmit()
  }

  submitResult(event) {
    this.submitTarget.removeAttribute("disabled")

    const status = event.detail.fetchResponse.response.status
    if (status == 201 || status == 202) {
      this.close(event)
    }
  }

  toggleBackdrop() {
    this.backdropOutlets.forEach(backdrop => backdrop.toggleTransition())
  }

  clearTimeouts() {
    this.timeouts.forEach(t => clearTimeout(t))
  }
}
