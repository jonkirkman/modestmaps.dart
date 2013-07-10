
import 'package:unittest/unittest.dart';
import 'package:modestmaps_dart/modestmaps.dart' as MM;

main() {
  group('Extent', () {
    var ext;

    setUp(() {
      ext = new MM.Extent(-10, -10, 10, 10);
    });

    test('properly initializes its sides', () {
      expect( ext.north, equals(-10) );
      expect( ext.west,  equals(-10) );
      expect( ext.south, equals(10) );
      expect( ext.east,  equals(10) );
    });

    test('expands to fit a location', () {
      var a = new MM.Location(-40, -40);

      ext.encloseLocation(a);

      expect( ext.west, equals(-40) );
      expect( ext.south, equals(-40) );
    });

    test('expands to fit locations', () {
      var a = new MM.Location(-40, -40);
      var b = new MM.Location(40, 40);

      ext.encloseLocations([a, b]);

      expect( ext.west, equals(-40) );
      expect( ext.east, equals(40) );
      expect( ext.south, equals(-40) );
      expect( ext.north, equals(40) );
    });

    test('knows when it contains a location', () {
      var a = new MM.Location(1, 1);
      expect( ext.containsLocation(a), isTrue );

      var b = new MM.Location(0, 90);
      expect( ext.containsLocation(b), isFalse );

      var c = new MM.Location(20, -20);
      expect( ext.containsLocation(c), isFalse );

      var d = new MM.Location(-9, -9);
      expect( ext.containsLocation(d), isTrue );
    });

  });
}
