
part of modestmaps;

class Layer {
	var parent,
		name,
		enabled,
		tiles,
		levels,
		requestManager,
		provider,
		_tileComplete;

	getTileComplete() {}

	getTileError() {}

	draw() {}

	// For a given tile coordinate in a given level element, ensure that it's
	// correctly represented in the DOM including potentially-overlapping
	// parent and child tiles for pyramid loading.
	//
	// Return a list of valid (i.e. loadable?) tile keys.
	inventoryVisibleTile() {}

	tileElementsInLevel() {}

	/**
	 * For a given level, adjust visibility as a whole and discard individual
	 * tiles based on values in valid_tile_keys from inventoryVisibleTile().
	 */
	adjustVisibleLevel() {}

	createOrGetLevel() {}

	addTileImage() {}

	addTileElement() {}

	positionTile() {}

	var _redrawTimer;

	requestRedraw() {}

	var _redraw;

	getRedraw() {}

	setProvider() {}

	// Enable a layer and show its dom element
	enable() {}

	// Disable a layer, don't display in DOM, clear all requests
	disable() {}

	// Remove this layer from the DOM, cancel all of its requests
	// and unbind any callbacks that are bound to it.
	destroy() {}
}
