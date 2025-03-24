import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    this.originalContent = this.element.innerHTML
  }

  copy() {
    navigator.clipboard.writeText(this.contentValue).then(
      () => {
        this.element.textContent = "コピーしました！"
        setTimeout(()=>{
          this.element.innerHTML = this.originalContent
        }, 2000)
      },
      () => {[
        alert("クリップボードにコピーできませんでした")
      ]}
    )
  }
}
