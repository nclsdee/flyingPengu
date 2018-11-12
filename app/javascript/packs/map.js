import GMaps from 'gmaps/gmaps.js';
const styles = [
{
  "featureType": "administrative",
  "elementType": "all",
  "stylers": [
  {
    "visibility": "on"
  },
  {
    "lightness": 33
  }
  ]
},
{
  "featureType": "landscape",
  "elementType": "all",
  "stylers": [
  {
    "color": "#f2e5d4"
  }
  ]
},
{
  "featureType": "poi.park",
  "elementType": "geometry",
  "stylers": [
  {
    "color": "#c5dac6"
  }
  ]
},
{
  "featureType": "poi.park",
  "elementType": "labels",
  "stylers": [
  {
    "visibility": "on"
  },
  {
    "lightness": 20
  }
  ]
},
{
  "featureType": "road",
  "elementType": "all",
  "stylers": [
  {
    "lightness": 20
  }
  ]
},
{
  "featureType": "road.highway",
  "elementType": "geometry",
  "stylers": [
  {
    "color": "#c5c6c6"
  }
  ]
},
{
  "featureType": "road.arterial",
  "elementType": "geometry",
  "stylers": [
  {
    "color": "#e4d7c6"
  }
  ]
},
{
  "featureType": "road.local",
  "elementType": "geometry",
  "stylers": [
  {
    "color": "#fbfaf7"
  }
  ]
},
{
  "featureType": "water",
  "elementType": "all",
  "stylers": [
  {
    "visibility": "on"
  },
  {
    "color": "#acbcc9"
  }
  ]
}
];


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

map.addStyle({
  styles: styles,
  mapTypeId: 'map_style'
});
map.setStyle('map_style');
}






