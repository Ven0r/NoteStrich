import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
    preprocess: vitePreprocess(),
    kit: {
        adapter: adapter({
            // Specify fallback to support client-side routing
            fallback: 'index.html'
        }),
        prerender: {
            // This option can be set to true to automatically prerender all pages that don’t have any `load` functions
            entries: ['*']
        }
    }
};

export default config;

