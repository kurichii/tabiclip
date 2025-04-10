import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="input-datetime"
export default class extends Controller {
  static targets = [ "startDate", "endDate" ]

  copyStartToEnd(){
    // end_dateにstart_dateの入力値を反映
    this.endDateTarget.value = this.startDateTarget.value;
  }
}

