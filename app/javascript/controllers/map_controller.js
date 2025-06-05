import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      zoom: 5,
      center: [this.markersValue[0].lng, this.markersValue[0].lat],
      style: "mapbox://styles/mapbox/streets-v10"
    })
     this.#addMarkersToMap()
     this.#fitMapToMarkers()
  }
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 100, maxZoom: 10, duration: 0 });
   setTimeout(() => {
    this.map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 2000 }); 
    }, 1000);
  }
}

