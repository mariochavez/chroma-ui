import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = ["panels"]

  execute(event) {
    event.preventDefault()

    const button = event.target
    button.setAttribute("disabled", true)

    this.panelsOutlets.forEach(panels => panels.submit())
  }

  done() {
    this.element.removeAttribute("disabled")
  }
}
