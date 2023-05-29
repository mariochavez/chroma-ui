import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use";

export default class extends Controller {
  static targets = ["sidebar"]
  static outlets = ["backdrop"]

  connect() {
    useTransition(this, { element: this.sidebarTarget })
    this.open = false
  }

  toggleSidebar() {
    if (!this.open) {
      this.toggleBackdrop()
    }

    this.toggleTransition()

    if (this.open) {
      this.toggleBackdrop()
    }

    this.open = !this.open
  }

  toggleBackdrop() {
    this.backdropOutlets.forEach(backdrop => backdrop.toggleTransition())
  }
}
