
part of modestmaps;

// Providers
// ---------
// Providers provide tile URLs and possibly elements for layers.
//
// MapProvider ->
//   Template
//

abstract class MapProvider {

	// these are limits for available *tiles*
	// panning limits will be different (since you can wrap around columns)
	// but if you put Infinity in here it will screw up sourceCoordinate
	List<Coordinate> tileLimits;
	String tileUrl;

	MapProvider();

	Uri getTileUrl(Coordinate coordinate);

	void getTile(Coordinate coordinate);

	// releaseTile is not required
	void releaseTile() {}

	// use this to tell MapProvider that tiles only exist between certain zoom levels.
	// should be set separately on Map to restrict interactive zoom/pan ranges
	void setZoomRange(num minZoom, num maxZoom) {
	  tileLimits[0] = tileLimits[0].zoomTo(minZoom);
    tileLimits[1] = tileLimits[1].zoomTo(maxZoom);
	}

	// wrap column around the world if necessary
	// return null if wrapped coordinate is outside of the tile limits
	Coordinate sourceCoordinate(Coordinate coord) {
	  var TL = tileLimits[0].zoomTo(coord.zoom).container(),
        BR = tileLimits[1].zoomTo(coord.zoom),
        columnSize = pow(2, coord.zoom),
        wrappedColumn;

    BR = new Coordinate(BR.row.ceil(), BR.column.ceil(), BR.zoom.floor());

    if (coord.column < 0) {
      wrappedColumn = ((coord.column % columnSize) + columnSize) % columnSize;
    } else {
      wrappedColumn = coord.column % columnSize;
    }

    if (coord.row < TL.row || coord.row >= BR.row) {
      return null;
    } else if (wrappedColumn < TL.column || wrappedColumn >= BR.column) {
      return null;
    } else {
      return new Coordinate(coord.row, wrappedColumn, coord.zoom);
    }
	}
}

/**
 * FIXME: need a better explanation here! This is a pretty crucial part of
 * understanding how to use ModestMaps.
 *
 * TemplatedMapProvider is a tile provider that generates tile URLs from a
 * template string by replacing the following bits for each tile
 * coordinate:
 *
 * {Z}: the tile's zoom level (from 1 to ~20)
 * {X}: the tile's X, or column (from 0 to a very large number at higher
 * zooms)
 * {Y}: the tile's Y, or row (from 0 to a very large number at higher
 * zooms)
 *
 * E.g.:
 *
 * var osm = new MM.TemplatedMapProvider("http://tile.openstreetmap.org/{Z}/{X}/{Y}.png");
 *
 * Or:
 *
 * var placeholder = new MM.TemplatedMapProvider("http://placehold.it/256/f0f/fff.png&text={Z}/{X}/{Y}");
 *
 */
class Template extends MapProvider {

	bool isQuadKey, hasSubdomains;
	String urlTemplate;
	List<String> subdomains;

	Template(this.urlTemplate, this.subdomains) {
     isQuadKey = urlTemplate.contains(new RegExp(r'{(Q|quadkey)}'));
    // replace Microsoft style substitution strings
	  if(isQuadKey) {
	    urlTemplate
	     .replaceAll('{subdomains}', '{S}')
       .replaceAll('{zoom}', '{Z}')
       .replaceAll('{quadkey}', '{Q}');
	  }

    hasSubdomains = (subdomains.isNotEmpty && urlTemplate.contains("{S}"));
	}

	Uri getTile(Coordinate coord) {
    return this.getTileUrl(coord);
  }

	num quadKey(int row, int column, int zoom) {
	  var key = 0;
    for (var i = 1; i <= zoom; i++) {
      key += (((row >> zoom - i) & 1) << 1) | ((column >> zoom - i) & 1);
    }
    return key;
	}

  Uri getTileUrl(Coordinate coordinate) {
    var coord = sourceCoordinate(coordinate);

    if (!coord) {
      return null;
    }

    var base = urlTemplate;

    if (hasSubdomains) {
      var index = (coord.zoom + coord.row + coord.column) % subdomains.length;
      base.replaceFirst('{S}', subdomains[index]);
    }

    if (isQuadKey) {
      base
          .replaceFirst('{Z}', coord.zoom.floor())
          .replaceFirst('{Q}', quadKey(coord.row.toInt(), coord.column.toInt(), coord.zoom.toInt()));
    } else {
      base
          .replaceFirst('{Z}', coord.zoom.floor())
          .replaceFirst('{X}', coord.column.round().toString())
          .replaceFirst('{Y}', coord.row.round().toString());
    }

    return Uri.parse(base);
  }
}

//class TemplatedLayer {
//  TemplateLayer(String urlTemplate, List<String> subdomains, String name) {
//    return new Layer(new Template(urlTemplate, subdomains), null, name);
//  }
//}
