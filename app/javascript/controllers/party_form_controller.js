import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "categoryInput"]

  onCategoryClick(event) {
    const button = event.currentTarget
    this.categoryInputTarget.value = button.innerHTML
    this.formTarget.submit()
  }
}

