
part of modestmaps;

// Coordinate
// ----------
// An object representing a tile position, at as specified zoom level.
// This is not necessarily a precise tile - `row`, `column`, and
// `zoom` can be floating-point numbers, and the `container()` function
// can be used to find the actual tile that contains the point.

class Coordinate {
  num row, column, zoom;

  Coordinate(this.row, this.column, this.zoom);

	// The coordinate as "(row, col, @zoom)"
	String toString() {
	  return "(${row.toStringAsFixed(3)}, "
	      "${column.toStringAsFixed(3)} "
	      "@${zoom.toStringAsFixed(3)})";
	}

	// Quickly generate a string representation of this coordinate to
	// index it in hashes.
	String toKey() => "$row,$column,$zoom";
    // We've tried to use efficient hash functions here before but we took
    // them out. Contributions welcome but watch out for collisions when the
    // row or column are negative and check thoroughly (exhaustively) before
    // committing.

	// Clone this object.
	Coordinate copy() {
	  new Coordinate(row, column, zoom);
	}

  // Get the actual, rounded-number tile that contains this point.
	Coordinate container() {
	  return new Coordinate(row.floor(), column.floor(), zoom.floor());
	}

	// Recalculate this Coordinate at a different zoom level and return the
	// new object.
	Coordinate zoomTo(num zoomLevel) {
	  num power = pow(2, zoomLevel - zoom);
	  return new Coordinate(row * power, column * power, zoomLevel);
	}

	// Recalculate this Coordinate at a different relative zoom level and return the
	// new object.
	Coordinate zoomBy(num zoomAdjust) {
	  num power = pow(2, zoomAdjust);
    return new Coordinate(row * power, column * power, zoom + zoomAdjust);
	}

	// Move this coordinate up by `dist` coordinates
	Coordinate up([num adjust = 1]) {
	  return new Coordinate(row - adjust, column, zoom);
	}

	// Move this coordinate right by `dist` coordinates
	Coordinate right([num adjust = 1]) {
	  return new Coordinate(row, column + adjust, zoom);
	}

	// Move this coordinate down by `dist` coordinates
	Coordinate down([num adjust = 1]) {
	  return new Coordinate(row + adjust, column, zoom);
	}

	// Move this coordinate left by `dist` coordinates
	Coordinate left([num adjust = 1]) {
	  return new Coordinate(row, column - adjust, zoom);
	}
}
