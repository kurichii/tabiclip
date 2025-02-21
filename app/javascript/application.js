// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
  let map = document.getElementById("map")
  const inputSpotName = document.getElementById("spotName");

  // mapの表示領域がある場合はinitMap実行
  if(map){
    initMap();
  }
  // 場所名のinputフォームがある場合はinitAutocompleteを実行
  if(inputSpotName){
    initAutocomplete();
  }
});