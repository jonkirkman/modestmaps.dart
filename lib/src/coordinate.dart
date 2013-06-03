
part of modestmaps;

// Coordinate
// ----------
// An object representing a tile position, at as specified zoom level.
// This is not necessarily a precise tile - `row`, `column`, and
// `zoom` can be floating-point numbers, and the `container()` function
// can be used to find the actual tile that contains the point.

class Coordinate {
  double row, column, zoom;

  Coordinate(this.row, this.column, this.zoom);

	// The coordinate as "(row, col, @zoom)"
	String toString() {
	  return """
      (${this.row.toStringAsFixed(3)}, 
      ${this.column.toStringAsFixed(3)}, 
      @${this.zoom.toStringAsFixed(3)})
      """;
	}

	// Quickly generate a string representation of this coordinate to
	// index it in hashes.
	String toKey() => "$this.row,$this.column,$this.zoom";
    // We've tried to use efficient hash functions here before but we took
    // them out. Contributions welcome but watch out for collisions when the
    // row or column are negative and check thoroughly (exhaustively) before
    // committing.

	// Clone this object.
	Coordinate copy() {
	  new Coordinate(this.row, this.column, this.zoom);
	}

  // Get the actual, rounded-number tile that contains this point.
	Coordinate container() {
	  return new Coordinate(this.row.floor(), this.column.floor(), this.zoom.floor());
	}

	// Recalculate this Coordinate at a different zoom level and return the
	// new object.
	Coordinate zoomTo(num zoomLevel) {
	  num power = pow(2, zoomLevel - this.zoom);
	  return new Coordinate(this.row * power, this.column * power, zoomLevel);
	}

	// Recalculate this Coordinate at a different relative zoom level and return the
	// new object.
	Coordinate zoomBy(num zoomAdjust) {
	  num power = pow(2, zoomAdjust);
    return new Coordinate(this.row * power, this.column * power, this.zoom + zoomAdjust);
	}

	// Move this coordinate up by `dist` coordinates
	Coordinate up(num adjust) {
	  return new Coordinate(this.row - adjust, this.column, this.zoom);
	}

	// Move this coordinate right by `dist` coordinates
	Coordinate right(num adjust) {
	  return new Coordinate(this.row, this.column + adjust, this.zoom);
	}

	// Move this coordinate down by `dist` coordinates
	Coordinate down(num adjust) {
	  return new Coordinate(this.row + adjust, this.column, this.zoom);
	}

	// Move this coordinate left by `dist` coordinates
	Coordinate left(num adjust) {
	  return new Coordinate(this.row, this.column - adjust, this.zoom);
	}
}
