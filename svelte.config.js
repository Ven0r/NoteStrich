import adapter from '@sveltejs/adapter-auto';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: vitePreprocess(),

  kit: {
    adapter: adapter(),

    // Use the correct prerender syntax if needed
    prerender: {
      // Prerender specific routes, or use '*', but do not use `default` as it is not valid
      entries: ['*']  // This will attempt to prerender all pages that are statically renderable
    }
  }
};

export default config;

