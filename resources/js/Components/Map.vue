<template>
    <div class="relative w-full h-screen">
        <div id="map" class="w-full h-full"></div>

        <div class="absolute top-0 right-0 p-4 z-50">
            <img src="@/Assets/images/logo.png" class="w-40" alt="test" />
        </div>
    </div>
</template>

<script setup>
import { onMounted } from 'vue'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import gta5 from '@/Assets/images/RDMP.png'
import policeIcon from '@/Assets/images/icons/test.png';
import hospitalIcon from '@/Assets/images/icons/test.png';

onMounted(() => {
    // Leaflet-Karte initialisieren
    const width = 7000;
    const height = 4000;
    const map = L.map('map', {
        crs: L.CRS.Simple,
        minZoom: -2,
        zoomControl: true,
        attributionControl: false,
        maxBounds: [[0, 0], [height, width]],
        maxBoundsViscosity: 1.0 // 👈 Richtig hier platzieren!
    });


    // Beispielgröße der Karte – anpassen auf dein Bildverhältnis

    const bounds = [[0, 0], [height, width]];

    // Mapbild einbinden
    const image = L.imageOverlay(gta5, bounds).addTo(map);

    // Karte auf die Bildgrenzen anpassen
    map.fitBounds(bounds);

    // Maximalgrenzen setzen, um das Panning zu begrenzen
    map.setMaxBounds(bounds);

    // Beispielblips
    const blips = [
        { name: 'Polizei', coords: [2200, 1500], icon: policeIcon },
        { name: 'Krankenhaus', coords: [2000, 1800], icon: hospitalIcon }
    ];


    blips.forEach(blip => {
        const icon = L.icon({
            iconUrl: blip.icon,
            iconSize: [32, 32],
            iconAnchor: [16, 16],
            popupAnchor: [0, -16]
        });

        L.marker(blip.coords, { icon })
            .addTo(map)
            .bindPopup(blip.name);
    });
});
</script>

<style>
#map {
    width: 100%;
    height: 100vh;
}

#map {
    background-color: #1D1D1D; /* Deine gewünschte Hintergrundfarbe */
}

</style>
