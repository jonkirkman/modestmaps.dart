
part of modestmaps;

// Instance of a map intended for drawing to a div.
//
//  * `parent` (required DOM element)
//      Can also be an ID of a DOM element
//  * `provider` (required MM.MapProvider or URL template)
//  * `location` (required MM.Location)
//      Location for map to show
//  * `zoom` (required number)
Map mapByCenterZoon() {}

// Instance of a map intended for drawing to a div.
//
//  * `parent` (required DOM element)
//      Can also be an ID of a DOM element
//  * `provider` (required MM.MapProvider or URL template)
//  * `locationA` (required MM.Location)
//      Location of one map corner
//  * `locationB` (required MM.Location)
//      Location of other map corner
Map mapByExtent() {}