// app/javascript/controllers/creator_fields_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["role", "creatorFields"]

  connect() {
    this.toggle()
  }

  toggle() {
    const isCreator = this.roleTarget.value === "creator"
    this.creatorFieldsTargets.forEach((el) => {
      el.style.display = isCreator ? "" : "none"
    })
  }
}
