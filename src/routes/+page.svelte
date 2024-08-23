<script lang="ts">
	import { nostrClient } from '../lib/nostrClient';
	import Login from '../components/Login.svelte';
	let metadata = null;
	let relays = [];
	let error = '';

	async function handleLogin(event) {
		const pubkey = event.detail.pubkey;
		console.log(`Logged in with pubkey: ${pubkey}`);

		const relayUrls = ['wss://relay.damus.io', 'wss://nostr-pub.wellorder.net'];
		await nostrClient.connectToRelays(relayUrls);

		try {
			// Fetch metadata
			const metadataMap = await nostrClient.fetchMetadata([pubkey]);
			metadata = metadataMap.get(pubkey);

			// Fetch associated relays
			relays = await nostrClient.fetchRelays(pubkey);
			console.log('Fetched relays:', relays);
		} catch (err) {
			error = `Failed to fetch data: ${err.message}`;
			console.error(error);
		}
	}
</script>

<div class="min-h-screen flex items-center justify-center bg-slate-800 text-white">
	<div class="text-center">
		<h1
			class="text-6xl md:text-8xl lg:text-9xl text-purple-600"
			style="font-family: 'Ostrich Sans', sans-serif;"
		>
			Notestrich
		</h1>

		{#if metadata}
			<div>
				<h2 class="text-4xl">User Metadata</h2>
				<p><strong>Name:</strong> {metadata.name}</p>
				<p><strong>About:</strong> {metadata.about}</p>
				<p><strong>Picture:</strong> <img src={metadata.picture} alt="Profile Picture" /></p>
				<p><strong>NIP-05:</strong> {metadata.nip05}</p>
				<!-- Display NIP-05 -->

				<h2 class="text-4xl mt-4">Associated Relays</h2>
				{#if relays.length > 0}
					<ul>
						{#each relays as relay}
							<li>{relay}</li>
						{/each}
					</ul>
				{:else}
					<p>No associated relays found.</p>
				{/if}
			</div>
		{:else if error}
			<p class="error">{error}</p>
		{:else}
			<Login on:login={handleLogin} />
		{/if}
	</div>
</div>

<style>
	.error {
		color: red;
		font-weight: bold;
	}
</style>
