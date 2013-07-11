part of modestmaps_test;

location_test() {
  group('Location', () {

    test('creates a location', () {
      var loc = new MM.Location(0, 1);

      expect( loc.lon, equals(1) );
      expect( loc.lat, equals(0) );
    });

    test('produces a nice string', () {
      var loc = new MM.Location(0, 1);

      expect( loc.toString(), equals('(0.000, 1.000)') );
    });

    test('can be copied', () {
      var loc = new MM.Location(0, 1);
      var cp = loc.copy();

      expect( cp, equals(loc) );
    });

    test('can calculate distance to another location', () {
      var a = new MM.Location(0, 1);
      var b = new MM.Location(0, 10);

      expect( MM.Location.distance(a, b), closeTo(1001853.897, 0.005) );
    });

    test('can interpolate a new location', () {
      var a = new MM.Location(0, 1);
      var b = new MM.Location(0, 10);

      expect( MM.Location.interpolate(a, b, 0.5).lat, closeTo(0, 0.005) );
      expect( MM.Location.interpolate(a, b, 0.5).lon, closeTo(5.5, 0.005) );
      // TODO: Test interpolatation where both lat & lon values differ
    });

    test('can produce a bearing between points', () {
      var a = new MM.Location(0, 1);
      var b = new MM.Location(0, 10);
      var c = new MM.Location(10, 1);

      expect( MM.Location.bearing(a, b), equals(90) );
      expect( MM.Location.bearing(a, c), equals(0) );
    });

  });
}
