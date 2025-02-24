import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {

  changeTab(event){
    const changeSpots = JSON.parse(event.target.getAttribute("data-spots") || "[]");
    window.spots = changeSpots;
    initMap();
  }
}
