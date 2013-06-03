
part of modestmaps;

// Extent
// ----------
// An object representing a map's rectangular extent, defined by its north,
// south, east and west bounds.

class Extent {
	double north, south, east, west;

	Extent(this.north, this.south, this.east, this.west);

	Extent.fromString(String str) {}

  Extent.fromList(List<Location> locations) {
    this.setFromLocations(locations);
  }

	Extent.fromArray(List<Location> locations) {
	  this.setFromLocations(locations);
	}


	Extent copy() {
		return new Extent(this.north, this.south, this.east, this.west);
	}

	String toString([int precision = 3]) {
    return '''
      ${this.north.toStringAsFixed(precision)},
      ${this.west.toStringAsFixed(precision)},
      ${this.south.toStringAsFixed(precision)},
      ${this.east.toStringAsFixed(precision)}
    ''';
	}

	// getters for the corner locations
	Location get northWest => new Location(this.north, this.west);

	Location get southEast => new Location(this.south, this.east);

	Location get northEast => new Location(this.north, this.east);

	Location get southWest => new Location(this.south, this.west);

	// getter for the center location
	Location get center {
    return new Location(
        this.south + (this.north - this.south) * 0.5,
        this.east + (this.west - this.east) * 0.5
    );
	}

	// extend the bounds to include a location's latitude and longitude
	void encloseLocation(Location loc) {
	  if (loc.lat > this.north) this.north = loc.lat;
    if (loc.lat < this.south) this.south = loc.lat;
    if (loc.lon > this.east) this.east = loc.lon;
    if (loc.lon < this.west) this.west = loc.lon;
	}

	// extend the bounds to include multiple locations
	void encloseLocations(List<Location> locations) {
	  locations.forEach((loc) => this.encloseLocation(loc));
	}

  // reset bounds from a list of locations
	void setFromLocations(List<Location> locations) {
    this.north = this.south = locations.first.lat;
    this.east = this.west = locations.first.lon;
    this.encloseLocations(locations);
  }

	// extend the bounds to include another extent
	void encloseExtent(Extent extent) {
	  if (extent.north > this.north) this.north = extent.north;
    if (extent.south < this.south) this.south = extent.south;
    if (extent.east > this.east) this.east = extent.east;
    if (extent.west < this.west) this.west = extent.west;
	}

	// determine if a location is within this extent
	bool containsLocation(Location loc) {
	  return loc.lat >= this.south &&
        loc.lat <= this.north &&
        loc.lon >= this.west &&
        loc.lon <= this.east;
	}

	// turn an extent into a List of locations containing its northwest
	// and southeast corners (used in Map.setExtent())
	List<Location> toList() => new List(this.northWest, this.southEast);
	// adding toArray method to match the JS API
	List<Location> toArray() => this.toList();

}
