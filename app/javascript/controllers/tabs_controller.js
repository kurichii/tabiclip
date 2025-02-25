import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static values = { spots: Array }

  changeTab(event){
    this.spotsValue = JSON.parse(event.target.getAttribute("data-tabs-spots-value"));
    window.spots = this.spotsValue;
    initMap();
  }
}
