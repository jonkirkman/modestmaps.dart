part of modestmaps_test;

projection_test() {
  group('Projection', () {
    var m, l;

    setUp(() {
      m = new MM.MercatorProjection(10);
      l = new MM.LinearProjection(10);
    });

    test('can instantiate a mercator projection', () {
      var a = new MM.Location(0, 0);
      var b = new MM.Coordinate(0, 0, 10);

      expect( m.locationCoordinate(a).column, equals(0) );
      expect( m.locationCoordinate(a).zoom, equals(10) );
      expect( m.coordinateLocation(b), equals(a) );
    });

    test('linear projects do not change normal points', () {
      var p = new MM.Point(10, 10);

      expect( l.project(p).x, equals(10) );
      expect( l.project(p).y, equals(10) );
      expect( l.unproject(p).x, equals(10) );
      expect( l.unproject(p).y, equals(10) );
    });

    test('is accurate up to 3 decimals', () {
      // Confirm that these values are valid up to a 3 decimals
      var c2 = m.locationCoordinate(new MM.Location(37, -122));

      expect( c2.row, closeTo(0.696, 0.001) );
      expect( c2.column, closeTo(-2.129, 0.001) );
      expect( c2.zoom, equals(10) );
    });

    test('can translate a Coordinate to a Location', () {
      var l2 = m.coordinateLocation(new MM.Coordinate(0.696, -2.129, 10));
      expect( l2.lat, closeTo(37.001, 0.001) );
      expect( l2.lon, closeTo(-121.983, 0.001) );
    });

  });
}
