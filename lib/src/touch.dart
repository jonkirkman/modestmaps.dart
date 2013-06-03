
part of modestmaps;

class TouchHandler {

	// var handler = { id: 'TouchHandler' },
	// 	map,
	// 	maxTapTime = 250,
	// 	maxTapDistance = 30,
	// 	maxDoubleTapDelay = 350,
	// 	locations = {},
	// 	taps = [],
	// 	snapToZoom = true,
	// 	wasPinching = false,
	// 	lastPinchCenter = null;
	
	TouchHandler() {}


	bool isTouchable() {}

	void updateTouches() {}

	// Test whether touches are from the same source -
	// whether this is the same touchmove event.
	bool sameTouch() {}


	void touchStart() {}

	void touchMove() {}

	void touchEnd() {}

	// Handle a tap event - mainly watch for a doubleTap
	void onTap() {}

	// Not yet implemented
	void onHold() {}

	// Handle a double tap by zooming in a single zoom level to a
	// round zoom.
	void onDoubleTap() {}

	// Re-transform the actual map parent's CSS transformation
	void onPanning() {}

	void onPinching() {}

	// When a pinch event ends, round the zoom of the map.
	void onPinched() {}

}
