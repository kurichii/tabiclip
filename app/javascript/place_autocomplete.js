document.addEventListener("turbo:load", function() {
  console.log("turbo:load");
  initMap();
});

function initMap() {
  // 場所名
  const inputSpotName = document.getElementById("spotName");
  // 電話番号
  const inputPhoneNumber = document.getElementById("phoneNumber");
  // 住所
  const inputAddress = document.getElementById("address");


  function setAutocomplete(inputElement){
    const options = {
      componentRestrictions: { country: 'JP' }
    };
    const autocomplete = new google.maps.places.Autocomplete(inputElement, options);

    autocomplete.addListener("place_changed", function() {
      const place = autocomplete.getPlace();
      // 場所名、電話番号、住所を更新する(nilかundefinedの場合は空文字)
      inputSpotName.value = place.name ?? "";
      inputPhoneNumber.value = place.formatted_phone_number ?? "";
      inputAddress.value = place.formatted_address ?? "";
    });
  }
  // 場所名のオートコンプリート
  if(inputSpotName){
    setAutocomplete(inputSpotName);
  }
  // 住所のオートコンプリート
  if(inputAddress){
    setAutocomplete(inputAddress);
  }
}

window.initMap = initMap;
