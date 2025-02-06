import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  go(event) {
    const url = event.currentTarget.dataset.url;
    if (url) {
      window.location.href = url;
    }
  }
}