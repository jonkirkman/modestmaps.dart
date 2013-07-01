
part of modestmaps;

// Instance of a map intended for drawing to a div.
//
//  * `parent` (required DOM element)
//      Can also be an ID of a DOM element
//  * `layerOrLayers` (required MM.Layer or Array of MM.Layers)
//      each one must implement draw(), destroy(), have a .parent DOM element and a .map property
//      (an array of URL templates or MM.MapProviders is also acceptable)
//  * `dimensions` (optional Point)
//      Size of map to create
//  * `eventHandlers` (optional Array)
//      If empty or null MouseHandler will be used
//      Otherwise, each handler will be called with init(map)

class Map {

	// DOM Element
	Element parent;
	// MM.Point with x/y size of parent element
	var dimensions;
	// MM.Projection of first known layer
	var projection;
	// Center of map MM.Coordinate with row/column/zoom
	var coordinate;
	// MM.Point with x/y size of tiles
	var tileSize;
	// Array of [ topLeftOuter, bottomLeftInner ] MM.Coordinates
	var coordLimits;
	// Array of MM.Layer (interface = .draw(), .destroy(), .parent and .map)
	var layers;
	// MM.CallbackManager, handles map events
	var callbackManager;
	// Array of interaction handlers, just a MM.MouseHandler by default
	var eventHandlers;
	// Boolean, true if we have a window resize listener
	var autoSize;

	Map(this.parent) {
	  parent.appendHtml("<h3>Oh hi.</h3>");
	}

	String toString() {
		return 'Map( $parent.id )';
	}


}
