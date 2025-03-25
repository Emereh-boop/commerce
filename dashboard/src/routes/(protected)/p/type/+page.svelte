<script lang="ts">
	import File from 'lucide-svelte/icons/file';
	import ListFilter from 'lucide-svelte/icons/list-filter';
	import Ellipsis from 'lucide-svelte/icons/ellipsis';
	import CirclePlus from 'lucide-svelte/icons/circle-plus';
	import * as Table from '$lib/components/ui/table';
	import { Badge } from '$lib/components/ui/badge';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Tabs from '$lib/components/ui/tabs';
	import { page } from '$app/stores';
	import type { PageData } from './$types';
	import CardContent from '$lib/components/ui/card/card-content.svelte';

	export let data: PageData;

	let storeId = $page.params.store;
	$: ({ Products } = data);
	$: console.log(Products);
	$: console.log($Products?.data?.products?.edges);

	const products = [
		{
			id: '1',
			product_type_id: 101,
			title: 'Wireless Headphones',
			price: '$199',
			image: '/headphones.jpg',
			digital: false,
			shippable: true,
			variations: ['Black', 'White', 'Blue']
		},
		{
			id: '2',
			product_type_id: 102,
			title: 'E-Book: JavaScript Mastery',
			price: '$29',
			image: '/ebook.jpg',
			digital: true,
			shippable: false,
			variations: ['PDF', 'EPUB', 'MOBI']
		},
		{
			id: '3',
			product_type_id: 103,
			title: 'Gaming Laptop',
			price: '$1499',
			image: '/laptop.jpg',
			digital: false,
			shippable: true,
			variations: ['512GB SSD', '1TB SSD']
		},
		{
			id: '4',
			product_type_id: 104,
			title: 'Online Coding Course',
			price: '$99',
			image: '/coding-course.jpg',
			digital: true,
			shippable: false,
			variations: ['Beginner', 'Intermediate', 'Advanced']
		}
	];
</script>

<div>
	<main class="grid flex-1 items-start gap-4 p-4 sm:px-6 sm:py-0 md:gap-8">
		<Tabs.Root value="all">
			<div class="flex items-center">
				<!-- <Tabs.List>
					<Tabs.Trigger value="all">All</Tabs.Trigger>
					<Tabs.Trigger value="active">Active</Tabs.Trigger>
					<Tabs.Trigger value="draft">Draft</Tabs.Trigger>
					<Tabs.Trigger value="archived" class="hidden sm:flex">Archived</Tabs.Trigger>
				</Tabs.List> -->
				<div class="ml-auto flex items-center gap-2">
					<DropdownMenu.Root>
						<DropdownMenu.Trigger asChild let:builder>
							<Button builders={[builder]} variant="outline" size="sm" class="h-7 gap-1">
								<ListFilter class="h-3.5 w-3.5" />
								<span class="sr-only sm:not-sr-only sm:whitespace-nowrap"> Filter </span>
							</Button>
						</DropdownMenu.Trigger>
						<DropdownMenu.Content align="end">
							<DropdownMenu.Label>Filter by</DropdownMenu.Label>
							<DropdownMenu.Separator />
							<DropdownMenu.CheckboxItem checked>Active</DropdownMenu.CheckboxItem>
							<DropdownMenu.CheckboxItem>Draft</DropdownMenu.CheckboxItem>
							<DropdownMenu.CheckboxItem>Archived</DropdownMenu.CheckboxItem>
						</DropdownMenu.Content>
					</DropdownMenu.Root>
					<Button size="sm" variant="outline" class="h-7 gap-1">
						<File class="h-3.5 w-3.5" />
						<span class="sr-only sm:not-sr-only sm:whitespace-nowrap"> Export </span>
					</Button>
					<Button size="sm" class="h-7 gap-1" href="/admin/{storeId}/p/create">
						<CirclePlus class="h-3.5 w-3.5" />
						<span class="sr-only sm:not-sr-only sm:whitespace-nowrap"> Add Product Type </span>
					</Button>
				</div>
			</div>
			<Tabs.Content value="all">
				<Card.Root>
					<Card.Header>
						<Card.Title>Product Types</Card.Title>
						<Card.Description>
							view your products types and edit their different variations.
						</Card.Description>
					</Card.Header>
					<Card.Content class="grid grid-cols-1 gap-6 p-4 sm:grid-cols-2 lg:grid-cols-4">
						{#each products as product}
							<Card.Root class="rounded-2xl p-4 shadow-lg relative">
								<CardContent class="mt-4">
									<h2 class="text-xl font-semibold">{product.title}</h2>
									<p class="text-sm text-gray-700">
										{product.digital ? 'Digital Product' : 'Physical Product'}
									</p>
									<p class="text-sm text-gray-700">
										{product.shippable ? 'Shippable' : 'Not Shippable'}
									</p>
									<div class="mt-2 text-sm text-gray-600">
										Variations: {product.variations.join(', ')}
									</div>
								</CardContent></Card.Root
							>
						{/each}
					</Card.Content>
					<Card.Footer>
						<div class="text-muted-foreground text-xs">
							Showing <strong>1-10</strong> of <strong>32</strong> products
						</div>
					</Card.Footer>
				</Card.Root>
			</Tabs.Content>
		</Tabs.Root>
	</main>
</div>
