import GMaps from 'gmaps/gmaps.js';

const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
   const markersDestination = JSON.parse(mapElement.dataset.destination);
   const markersHometown = JSON.parse(mapElement.dataset.hometown);



  console.log(mapElement.dataset);

  map.addMarkers(markersDestination);
  map.addMarkers(markersHometown);


   if (markersDestination.length === 0) {
    map.setZoom(2);
  } else if (markersDestination.length === 1) {
    map.setCenter(markersDestination[0].lat, markersDestination[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markersDestination);
  }

  if (markersHometown.length === 0) {
    map.setZoom(2);
  } else if (markersHometown.length === 1) {
    map.setCenter(markersHometown[0].lat, markersHometown[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markersHometown);
  }
}





