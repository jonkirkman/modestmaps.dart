
part of modestmaps;

// RequestManager
// --------------
// an image loading queue
class RequestManager {

	// The loading bay is a document fragment to optimize appending, since
	// the elements within are invisible. See
	//  [this blog post](http://ejohn.org/blog/dom-documentfragments/).
	// DOM element, hidden, for making sure images dispatch complete events
	var loadingBay;

	// all known requests, by ID
	var requestsById;

	// current open requests (children of loadingBay)
	var openRequestCount;

	// the number of open requests permitted at one time, clamped down
	// because of domain-connection limits.
	var maxOpenRequests;

	// current pending requests
	var requestQueue;

	// for dispatching 'requestcomplete'
	var callbackManager;

	var _loadComplete;

	addCallback() {}

	removeCallback() {}

	dispatchCallback() {}

	// Clear everything in the queue by excluding nothing
	clear() {}

	clearRequest() {}

	// Clear everything in the queue except for certain keys, specified
	// by an object of the form
	//
	//     { key: throwawayvalue }
	clearExcept() {}

	// Given a tile id, check whether the RequestManager is currently
	// requesting it and waiting for the result.
	hasRequest() {}

	// * TODO: remove dependency on coord (it's for sorting, maybe call it data?)
	// * TODO: rename to requestImage once it's not tile specific
	requestTile() {}

	getProcessQueue() {}

	// Select images from the `requestQueue` and create image elements for
	// them, attaching their load events to the function returned by
	// `this.getLoadComplete()` so that they can be added to the map.
	processQueue() {}

	// Get the singleton `_loadComplete` function that is called on image
	// load events, either removing them from the queue and dispatching an
	// event to add them to the map, or deleting them if the image failed
	// to load.
	getLoadComplete() {}
}
