import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use";

export default class extends Controller {
  static targets = ["backdrop"]

  connect() {
    useTransition(this, { element: this.backdropTarget })
  }
}
