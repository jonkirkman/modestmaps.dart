part of modestmaps_test;

coordinate_test() {
  group('Coordinate', () {

    var coordinate;

    setUp(() {
      coordinate = new MM.Coordinate(0, 0, 2);
    });

    test('provides a nice string', () {
      expect( coordinate.toString(), equals('(0.000, 0.000 @2.000)') );
    });

    test('generates a key', () {
      expect( coordinate.toKey() is String, isTrue );
    });

    test('can be copied', () {
      expect( coordinate.copy(), equals(coordinate) );
    });

    test('can give its container', () {
      var a = new MM.Coordinate(0.1, 0.1, 0);
      var b = a.container();
      expect( b.column, equals(0) );
      expect( b.row, equals(0) );
    });

    test('can be zoomed to a new zoom level', () {
      var a = new MM.Coordinate(0, 0, 2);
      expect( a.zoom, equals(2) );
      var b = a.zoomTo(4);
      expect( a.zoom, equals(2) );
      expect( b.zoom, equals(4) );
    });

    test('can provide a zoomed-in coordinate', () {
      expect( (coordinate.zoomBy(1)).zoom, equals(3) );
    });

    test('can provide a zoomed-out coordinate', () {
      expect( (coordinate.zoomBy(-1)).zoom, equals(1) );
    });

    test('can move up, left, right, and down', () {
      var a = new MM.Coordinate(0, 0, 2);
      expect( a.column, equals(0) );
      var b = a.right();
      expect( b.column, equals(1) );
      expect( b.row, equals(0) );
      var c = b.down();
      expect( c.row, equals(1) );
      var d = c.up();
      expect( d.row, equals(0) );
      var e = d.left();
      expect( e.column, equals(0) );
    });

    test('will yield a container', () {
      var oc = coordinate.copy();
      coordinate.right(0.1);
      expect( coordinate.container().column, equals(oc.column) );
    });

  });
}

