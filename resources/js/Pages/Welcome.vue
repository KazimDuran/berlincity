<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
import NavBar from "@/Components/NavBar.vue";
import { ref } from "vue";

// Image imports
import Image1 from "@/Assets/images/bg4.png";
import Image2 from "@/Assets/images/bg5.png";
import Image3 from "@/Assets/images/bg6.png";
import Image4 from "@/Assets/images/bg7.png"; // global
import Image5 from "@/Assets/images/bg8.png";
import Image6 from "@/Assets/images/bg9.png";
import Image7 from "@/Assets/images/bg10.png";
import police from "@/Assets/images/police.png";
import medizin from "@/Assets/images/mediziner.png";
import military from "@/Assets/images/army.png";
import gangster from "@/Assets/images/gangstar.png";
import geschaft from "@/Assets/images/geschaft.png";
import worker from "@/Assets/images/worker.png";


import Image1_Outline from "@/Assets/images/bg4_outline.png";
import Image2_Outline from "@/Assets/images/bg5_outline.png";
import Image3_Outline from "@/Assets/images/bg6_outline.png";
import Image4_Outline from "@/Assets/images/bg7_outline.png"; // global
import Image5_Outline from "@/Assets/images/bg8_outline.png";
import Image6_Outline from "@/Assets/images/bg9_outline.png";
import Image7_Outline from "@/Assets/images/bg10_outline.png";
import StepItem from "@/Components/StepItem.vue";
import Footer from "@/Components/Footer.vue";
import Slider from "@/Components/Slider.vue";
import Gallery from "@/Components/Gallery.vue";

// Hover states
const globalHover = ref(false); // nur Bild 4
const hoveredIndex = ref<number | null>(null);

const images = [
    {
        src: Image1,
        outline: Image1_Outline,
        alt: 'Screenshot 1',
        global: false,
        character: police,
        title: 'Werde Polizist',
    },
    {
        src: Image2,
        outline: Image2_Outline,
        alt: 'Screenshot 2',
        global: false,
        character: medizin,
        title: 'Werde Mediziner',
    },
    {
        src: Image3,
        outline: Image3_Outline,
        alt: 'Screenshot 3',
        global: false,
        character: gangster,
        title: 'Werde Mechaniker',
    },
    {
        src: Image4,
        outline: Image4_Outline,
        alt: 'Screenshot 4',
        global: true,
        character: '',
        title: 'Werde Held',
    },
    {
        src: Image5,
        outline: Image5_Outline,
        alt: 'Screenshot 5',
        global: false,
        character: military,
        title: 'Werde Held',
    },
    {
        src: Image6,
        outline: Image6_Outline,
        alt: 'Screenshot 6',
        global: false,
        character: geschaft,
        title: 'Werde Held',
    },
    {
        src: Image7,
        outline: Image7_Outline,
        alt: 'Screenshot 7',
        global: false,
        character: worker,
        title: 'Werde Held',
    },
];


function handleMouseEnter(img: { global: boolean }, index: number) {
    console.log("Hovered:", index, "Global:", img.global);
    if (img.global) {
        globalHover.value = true;
        hoveredIndex.value = null;
    } else {
        hoveredIndex.value = index;
        globalHover.value = false;
    }
}

const steps = [
    {
        title: 'GTA V kaufen',
        description: 'Besorge dir eine legale Kopie von GTA V über Steam, Epic Games oder Rockstar Launcher.',
        image: '/images/step1.png',
    },
    {
        title: 'FiveM installieren',
        description: 'Lade dir den FiveM-Client von fivem.net herunter und installiere ihn auf deinem PC.',
        image: '/images/step2.png',
    },
    {
        title: 'Nach Berlin City suchen',
        description: 'Starte FiveM, öffne den Server-Browser und suche nach "Berlin City".',
        image: '/images/step3.png',
    },
    {
        title: 'Beitreten & Losspielen',
        description: 'Wähle den Server aus, trete bei und erlebe Berlin City RP in voller Action!',
        image: '/images/step4.png',
    },
];

function handleMouseLeave() {
    globalHover.value = false;
    hoveredIndex.value = null;
}
</script>
<template>
    <Head title="Willkommen" />
    <div
        class="min-h-[60vh] w-screen relative overflow-hidden"
        :class="globalHover ? 'grayscale-off' : 'grayscale-on'"
    >
        <NavBar />
        <div class="w-full overflow-x-hidden">
            <div
                class="flex gap-2 sm:gap-4 mt-12 sm:mt-16 px-2 sm:px-8 w-max-7xl justify-center mx-auto transition-all duration-300"
            >
                <template v-for="(img, index) in images" :key="index">
                    <div
                        class="relative flex-shrink-0 rounded-2xl overflow-hidden transition-all duration-300 ease-in-out
                      w-[140px] sm:w-[160px] md:w-[120px] lg:w-[150px] xl:w-[190px]
                      h-[420px] sm:h-[480px] md:h-[540px] lg:h-[600px]
                      bg-cover bg-center flex items-center justify-center"
                        :style="{
                      backgroundImage: `url(${globalHover || hoveredIndex === index ? img.src : img.outline})`
                    }"
                        @mouseenter="handleMouseEnter(img, index)"
                        @mouseleave="handleMouseLeave"
                        :class="[
                        img.global
                          ? 'filter grayscale-0 cursor-pointer' // Kein Grayscale auf globalen Bildern
                          : (globalHover || hoveredIndex === index)
                            ? 'filter grayscale-0 cursor-pointer drop-shadow-[0_20px_30px_rgba(255,0,0,0.6)]'
                            : 'filter grayscale cursor-pointer'
                    ]"
                    >
                        <!-- Play-Button & Text für das globale Bild -->
                        <template v-if="img.global">
                            <div class="absolute bottom-10 flex flex-col items-center gap-4">
                                <!-- Play-Button -->
                                <div
                                    class="w-16 h-16 rounded-full bg-white flex items-center justify-center shadow-lg transition-all duration-300 ease-in-out"
                                    :class="globalHover ? 'scale-110 drop-shadow-[0_0px_10px_rgba(255,255,255,0.6)]' : 'scale-100 drop-shadow-none'"
                                >
                                    <svg class="w-8 h-8 text-red-500" fill="#b50505" viewBox="0 0 20 20">
                                        <path d="M6 4l10 6-10 6V4z"></path>
                                    </svg>
                                </div>

                                <!-- "SPIEL STARTEN" Text -->
                                <p class="text-white mt-10 font-bold text-lg uppercase stevie-sans-bold">SPIEL STARTEN</p>
                            </div>

                        </template>

                        <!-- Standard Inhalt (Charakterbild & Berufstitel) für andere Bilder -->
                        <template v-else>
                            <div class="absolute bottom-0 left-1/2 transform -translate-x-1/2 text-center text-white space-y-2">
                                <!-- Charakterbild -->
                                <div class="relative h-[250px] sm:h-[300px] md:h-[350px] lg:h-[400px] w-[140px] sm:w-[160px] md:w-[180px] lg:w-[200px] overflow-visible">
                                    <img
                                        :src="img.character"
                                        class="h-full w-full object-cover transition-all duration-300 ease-in-out"
                                        :class="[globalHover || hoveredIndex === index ? 'translate-y-0 scale-105' : 'translate-y-5 scale-100']"
                                    />
                                </div>
                                <!-- Berufstitel -->
                                <div v-if="hoveredIndex === index" class="font-bold uppercase stevie-sans-bold text-xs sm:text-sm bg-black/60 text-center px-2 py-1 rounded absolute bottom-14 sm:bottom-16 left-1/2 transform -translate-x-1/2 transition-opacity duration-300">
                                    {{ img.title }}
                                </div>
                            </div>
                        </template>
                    </div>
                </template>
            </div>
        </div>
    </div>
    <div class="w-full mt-10">
        <div class="max-w-[1420px] mx-auto">
            <StepItem />

            <!-- Slider + Galerie -->
            <div class="flex flex-col md:flex-row gap-4 text-white mt-10">
                <div class="md:w-6/12 w-full">
                    <Slider />
                </div>
                <div class="md:w-6/12 w-full">
                    <Gallery />

                </div>
            </div>


            <div class="py-14 sm:py-24">
                <div class="mx-auto max-w-[1420px] px-6 py-12 lg:px-8">
                    <div class="mx-auto max-w-2xl lg:max-w-none">
                        <h2 class="text-lg/8 font-semibold text-white uppercase stevie-sans-book">unsere partner</h2>
                        <div class="mx-auto mt-10 grid grid-cols-4 items-start gap-x-8 gap-y-10 sm:grid-cols-6 sm:gap-x-10 lg:mx-0 lg:grid-cols-5">
                            <img class="col-span-2 max-h-12 w-full object-contain object-left lg:col-span-1" src="https://tailwindcss.com/plus-assets/img/logos/transistor-logo-white.svg" alt="Transistor" width="158" height="48" />
                            <img class="col-span-2 max-h-12 w-full object-contain object-left lg:col-span-1" src="https://tailwindcss.com/plus-assets/img/logos/reform-logo-white.svg" alt="Reform" width="158" height="48" />
                            <img class="col-span-2 max-h-12 w-full object-contain object-left lg:col-span-1" src="https://tailwindcss.com/plus-assets/img/logos/tuple-logo-white.svg" alt="Tuple" width="158" height="48" />
                            <img class="col-span-2 max-h-12 w-full object-contain object-left lg:col-span-1" src="https://tailwindcss.com/plus-assets/img/logos/savvycal-logo-white.svg" alt="SavvyCal" width="158" height="48" />
                            <img class="col-span-2 max-h-12 w-full object-contain object-left lg:col-span-1" src="https://tailwindcss.com/plus-assets/img/logos/statamic-logo-white.svg" alt="Statamic" width="158" height="48" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <Footer />
</template>

<style>
.grayscale-on::before,
.grayscale-off::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image: url('@/Assets/images/Download.webp');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    z-index: -1;
    filter: grayscale(100%);

    /* Weicher Übergang von 100% Sichtbarkeit zu Transparenz am unteren Rand */
    -webkit-mask-image: linear-gradient(
        to bottom,
        rgba(0, 0, 0, 1) 0%,
        rgba(0, 0, 0, 1) 95%,
        rgba(0, 0, 0, 0.7) 98%,
        rgba(0, 0, 0, 0) 100%
    );
    mask-image: linear-gradient(
        to bottom,
        rgba(0, 0, 0, 1) 0%,
        rgba(0, 0, 0, 1) 95%,
        rgba(0, 0, 0, 0.7) 98%,
        rgba(0, 0, 0, 0) 100%
    );
    -webkit-mask-size: 100% 100%;
    mask-size: 100% 100%;
    -webkit-mask-repeat: no-repeat;
    mask-repeat: no-repeat;
}

.grayscale-off::before {
    filter: grayscale(0%);
}



/* In deiner main CSS Datei oder global */
html, body {
    overflow-x: hidden;
}

</style>
