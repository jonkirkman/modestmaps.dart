
part of modestmaps;

// Extent
// ----------
// An object representing a map's rectangular extent, defined by its north,
// south, east and west bounds.

class Extent {
  num north, west, south, east;

  Extent(this.north, this.west, this.south, this.east);

  Extent.fromString(String str) {}

  Extent.fromList(List<Location> locations) {
    this.setFromLocations(locations);
  }

  Extent.fromArray(List<Location> locations) {
    this.setFromLocations(locations);
  }


  Extent copy() {
    return new Extent(north, west, south, east);
  }

  String toString([int precision = 3]) {
    return '${north.toStringAsFixed(precision)}, '
           '${west.toStringAsFixed(precision)}, '
           '${south.toStringAsFixed(precision)}, '
           '${east.toStringAsFixed(precision)}';
  }

  // getters for the corner locations
  Location get northWest => new Location(north, west);

  Location get southEast => new Location(south, east);

  Location get northEast => new Location(north, east);

  Location get southWest => new Location(south, west);

  // getter for the center location
  Location get center {
    return new Location(
        south + (north - south) * 0.5,
        east + (west - east) * 0.5
    );
  }

  // extend the bounds to include a location's latitude and longitude
  void encloseLocation(Location loc) {
    if (loc.lat > north) north = loc.lat;
    if (loc.lat < south) south = loc.lat;
    if (loc.lon > east) east = loc.lon;
    if (loc.lon < west) west = loc.lon;
  }

  // extend the bounds to include multiple locations
  void encloseLocations(List<Location> locations) {
    locations.forEach((loc) => encloseLocation(loc));
  }

  // reset bounds from a list of locations
  void setFromLocations(List<Location> locations) {
    north = south = locations.first.lat;
    east = west = locations.first.lon;
    encloseLocations(locations);
  }

  // extend the bounds to include another extent
  void encloseExtent(Extent extent) {
    if (extent.north > north) north = extent.north;
    if (extent.south < south) south = extent.south;
    if (extent.east > east) east = extent.east;
    if (extent.west < west) west = extent.west;
  }

  // determine if a location is within this extent
  bool containsLocation(Location loc) {
    return loc.lat <= south &&
           loc.lat >= north &&
           loc.lon >= west &&
           loc.lon <= east;
  }

  // turn an extent into a List of locations containing its northwest
  // and southeast corners (used in Map.setExtent())
  List<Location> toList() => [northWest, southEast];
  // adding toArray method to match the JS API
  List<Location> toArray() => this.toList();

}
