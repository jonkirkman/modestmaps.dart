part of modestmaps_test;

point_test() {
  group('Point', () {

    test('creates a point', () {
      var p = new MM.Point(0, 1);
      expect(p.x, equals(0));
      expect(p.y, equals(1));
    });

    test('provides a nice string representation of itself', () {
      var p = new MM.Point(0, 0);
      expect(p.toString(), equals('(0.000, 0.000)'));
    });

    test('can yield a copy', () {
      var p = new MM.Point(0, 0);
      expect(p.copy(), equals(p));
    });

    test('correctly computes distance to another point', () {
      var p = new MM.Point(0,0);
      var q = new MM.Point(0, 10);
      expect(MM.Point.distance(p, q), equals(10));

      var p1 = new MM.Point(0, 0);
      var q1 = new MM.Point(5, 2);
      expect(MM.Point.distance(p1, q1), closeTo(5.3851, 0.05));
    });

    test('correctly interpolates positions', () {
      var p = new MM.Point(0, 0);
      var q = new MM.Point(0, 10);
      expect(MM.Point.interpolate(p, q, 0.5).y, equals(5));
    });

  });
}
