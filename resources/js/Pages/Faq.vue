<script setup lang="ts">
import {Head} from "@inertiajs/vue3";
import NavBar from "@/Components/NavBar.vue";

import { Disclosure, DisclosureButton, DisclosurePanel } from '@headlessui/vue'
import { MinusSmallIcon, PlusSmallIcon } from '@heroicons/vue/24/outline'
import { ref } from 'vue'

const openFaq = ref<string | null>(null)

function toggleFaq(question: string) {
    openFaq.value = openFaq.value === question ? null : question
}

const faqs = [
    {
        id: 1,
        question: "What's the best thing about Switzerland?",
        answer:
            "I don't know, but the flag is a big plus. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.",
    },
    {
        id: 2,
        question: "Why do programmers prefer dark mode?",
        answer:
            "Because the light attracts bugs. Plus, it looks cooler!",
    },
    {
        id: 3,
        question: "How do you comfort a JavaScript bug?",
        answer:
            "You console it. Sometimes even log its feelings.",
    },
    {
        id: 4,
        question: "Why was the math book sad?",
        answer:
            "Because it had too many problems. Classic.",
    },
];

const faqsMore = [
    {
        question: "Why don't scientists trust atoms?",
        answer:
            "Because they make up everything.",
    },
    {
        question: "What do you call fake spaghetti?",
        answer:
            "An impasta.",
    },
    {
        question: "Why did the scarecrow win an award?",
        answer:
            "Because he was outstanding in his field.",
    },
    {
        question: "What’s orange and sounds like a parrot?",
        answer:
            "A carrot.",
    },
];

</script>

<template>
    <Head title="Willkommen" />
    <div>
        <NavBar />

        <div class="mx-auto max-w-6xl px-6 py-16 sm:py-24 lg:px-8">
            <h2 class="text-4xl font-semibold tracking-tight text-white sm:text-5xl">Frequently asked questions</h2>
            <p class="mt-6 max-w-2xl text-base/7 text-gray-300">Have a different question and can’t find the answer you’re looking for? Reach out to our support team by <a href="#" class="font-semibold text-indigo-400 hover:text-indigo-300">sending us an email</a> and we’ll get back to you as soon as we can.</p>
            <div class="mt-20">
                <dl class="space-y-16 sm:grid sm:grid-cols-2 sm:gap-x-6 sm:gap-y-16 sm:space-y-0 lg:gap-x-10">
                    <div v-for="faq in faqs" :key="faq.id">
                        <dt class="text-base/7 font-semibold text-white">{{ faq.question }}</dt>
                        <dd class="mt-2 text-base/7 text-gray-300">{{ faq.answer }}</dd>
                    </div>
                </dl>
            </div>

            <h2 class="text-4xl font-semibold tracking-tight text-white sm:text-5xl mt-16">Frequently asked questions</h2>
            <dl class="mt-16 divide-y divide-white/10">
                <div
                    v-for="faq in faqsMore"
                    :key="faq.question"
                    class="py-6 first:pt-0 last:pb-0"
                >
                    <dt>
                        <button
                            @click="toggleFaq(faq.question)"
                            class="flex w-full items-start justify-between text-left text-white"
                        >
                            <span class="text-base/7 font-semibold">{{ faq.question }}</span>
                            <span class="ml-6 flex h-7 items-center">
                                <PlusSmallIcon v-if="openFaq !== faq.question" class="size-6" aria-hidden="true" />
                                <MinusSmallIcon v-else class="size-6" aria-hidden="true" />
                            </span>
                        </button>
                    </dt>
                    <dd v-if="openFaq === faq.question" class="mt-2 pr-12">
                        <p class="text-base/7 text-gray-300">{{ faq.answer }}</p>
                    </dd>
                </div>
            </dl>
        </div>


    </div>
</template>

<style scoped>

</style>
