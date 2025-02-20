// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
  // mapの表示領域か場所名のinputがある場合のみinitMapを実行
  let map = document.getElementById("map")
  const inputSpotName = document.getElementById("spotName");
  if(map || inputSpotName){
    initMap();
  }
});