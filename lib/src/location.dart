
part of modestmaps;

class Location {
	double lat = 0, lon = 0;

	static final double deg2rad = PI / 180;

  Location(this.lat, this.lon);

	String toString() => "(${this.lat.toStringAsFixed(3)}, ${this.lat.toStringAsFixed(3)})";

	Location copy() => new Location(this.lat, this.lon);

	// returns approximate distance between start and end locations
	//
	// default unit is meters
	//
	// you can specify different units by optionally providing the
	// earths radius in the units you desire
	//
	// Default is 6,378,000 metres, suggested values are:
	//
	// * 3963.1 statute miles
	// * 3443.9 nautical miles
	// * 6378 km
	//
	// see [Formula and code for calculating distance based on two lat/lon locations](http://jan.ucc.nau.edu/~cvm/latlon_formula.html)
	static num distance(Location l1, Location l2, [num r = 6378000]) {
    num a1 = l1.lat * deg2rad,
        b1 = l1.lon * deg2rad,
        a2 = l2.lat * deg2rad,
        b2 = l2.lon * deg2rad,
         c = cos(a1) * cos(b1) * cos(a2) * cos(b2),
         d = cos(a1) * sin(b1) * cos(a2) * sin(b2),
         e = sin(a1) * sin(a2);
    return acos(c + d + e) * r;
	}

	// Interpolates along a great circle, f between 0 and 1
	//
	// * FIXME: could be heavily optimized (lots of trig calls to cache)
	// * FIXME: could be inmproved for calculating a full path
	static Location interpolate(Location l1, Location l2, f) {
    if (l1 == l2) {
      return new Location(l1.lat, l1.lon);
    }

    final num lat1 = l1.lat * deg2rad,
        lon1 = l1.lon * deg2rad,
        lat2 = l2.lat * deg2rad,
        lon2 = l2.lon * deg2rad;

    num d = 2 * asin( sqrt(
      pow(sin((lat1 - lat2) * 0.5), 2) +
      cos(lat1) * cos(lat2) * pow(sin((lon1 - lon2) * 0.5), 2)
    ));

    num A = sin((1 - f) * d) / sin(d);
    num B = sin(f*d)/sin(d);
    num x = A * cos(lat1) * cos(lon1) + B * cos(lat2) * cos(lon2);
    num y = A * cos(lat1) * sin(lon1) + B * cos(lat2) * sin(lon2);
    num z = A * sin(lat1) + B * sin(lat2);

    num latN = atan2(z, sqrt(pow(x, 2) + pow(y, 2)));
    num lonN = atan2(y, x);

    return new Location(latN / deg2rad, lonN / deg2rad);
	}

	// Returns bearing from one point to another
	//
	// * FIXME: bearing is not constant along significant great circle arcs.
	static double bearing(Location l1, Location l2) {
    final num lat1 = l1.lat * deg2rad,
        lon1 = l1.lon * deg2rad,
        lat2 = l2.lat * deg2rad,
        lon2 = l2.lon * deg2rad;

    num result = atan2(
          sin(lon1 - lon2) * cos(lat2),
          cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon1 - lon2)
        ) / - deg2rad;

    // map it into 0-360 range
    return (result < 0) ? result + 360 : result;
	}
}
