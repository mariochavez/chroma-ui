import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab"]
  static classes = ["active", "inactive"]
  static outlets = ["panels"]

  connect() {
    this.active = this.tabTargets[0]
  }

  activate(event) {
    event.preventDefault()

    const tab = event.target
    if (this.active == tab) {
      return
    }

    this.active.classList.remove(...this.activeClasses)
    this.active.classList.add(...this.inactiveClasses)

    this.active = tab
    this.active.classList.remove(...this.inactiveClasses)
    this.active.classList.add(...this.activeClasses)

    const index = this.tabTargets.indexOf(this.active)
    this.panelsOutlets.forEach(panels => panels.activate(index))
  }
}
