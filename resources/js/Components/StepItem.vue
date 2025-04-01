<template>
    <section class="text-white py-20 relative overflow-hidden">
        <div>
            <h2 class="text-4xl font-bold text-center mb-16 flex justify-center items-center uppercase stevie-sans-bold">
                So spielst du auf
                <img src="@/Assets/images/logo.png" alt="Berlin City" class="h-10 ml-2 inline" />
            </h2>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-10 relative z-10">
                <div
                    v-for="(step, index) in steps"
                    :key="index"
                    class="relative group bg-[#1a1a1a] p-6 rounded-xl text-center overflow-hidden z-0"
                    @mousemove="updateGlow($event, index)"
                    @mouseleave="hideGlow(index)"
                >
                    <!-- Cursor Gradient Glow -->
                    <div
                        class="absolute -z-10 pointer-events-none w-[400px] h-[400px] transition-opacity duration-300 ease-out"
                        :style="glowStyles[index]"
                    ></div>

                    <!-- Inhalt -->
                    <h3 class="text-lg font-bold text-red-500 mb-4">SCHRITT {{ index + 1 }}</h3>
                    <p class="text-gray-300 mb-6" v-html="step.text"></p>

                    <div v-if="step.buttons" class="flex justify-center gap-2 flex-wrap">
                        <button
                            v-for="(btn, i) in step.buttons"
                            :key="i"
                            class="bg-gray-800 px-4 py-2 text-sm rounded hover:bg-gray-700"
                        >
                            {{ btn }}
                        </button>
                    </div>
                    <button
                        v-if="step.button"
                        class="bg-gray-800 px-4 py-2 text-sm rounded hover:bg-gray-700"
                    >
                        {{ step.button }}
                    </button>

                    <!-- kleiner roter Punkt für Step 3 -->
                    <div
                        v-if="index === 2"
                        class="w-3 h-3 bg-red-600 rounded-full absolute top-4 left-4 z-20"
                    ></div>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref } from 'vue'

const steps = [
    {
        text: 'Kaufe und installiere Red Dead Redemption 2<br /> Spiel bereits vorhanden? – Nächster Schritt',
        buttons: ['STEAM', 'EPIC GAMES', 'ROCKSTAR'],
    },
    {
        text: 'Lade herunter und installiere<br />RedM Multiplayer',
        button: 'DOWNLOAD RedM',
    },
    {
        text: 'Starte RedM und<br />suche nach <span class="uppercase font-bold">Westpoint</span> und trete bei!',
        button: 'Server beitreten',
    },
]

// Initial styles per card
const glowStyles = ref(
    steps.map(() => ({
        top: '0px',
        left: '0px',
        opacity: 0,
        background: '',
        transform: 'translate(-50%, -50%)',
        borderRadius: '9999px',
    }))
)

function updateGlow(event, index) {
    const rect = event.currentTarget.getBoundingClientRect()
    const x = event.clientX - rect.left
    const y = event.clientY - rect.top

    glowStyles.value[index] = {
        top: `${y}px`,
        left: `${x}px`,
        opacity: 0.5,
        background: `radial-gradient(circle at center, rgba(255,0,0,0.4) 0%, rgba(200,30,30,0.25) 40%, rgba(120,0,0,0.1) 80%, transparent 100%)`,
        transform: 'translate(-50%, -50%)',
        borderRadius: '9999px',
    }
}

function hideGlow(index) {
    glowStyles.value[index].opacity = 0
}
</script>

<style scoped>
/* Kein zusätzlicher CSS nötig für den Glow, alles inline mit Vue */
</style>
