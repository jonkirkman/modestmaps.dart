part of modestmaps_test;

transformation_test() {
  group('Transformation', () {

    test('can do an identity transform', () {
      var t = new MM.Transformation(1, 0, 0, 0, 1, 0);
      var p = new MM.Point(1, 1);

      expect(p, equals(new MM.Point(1, 1)) );

      var p_ = t.transform(p);
      expect(p_, equals(new MM.Point(1, 1)) );

      var p__ = t.untransform(p_);
      expect(p__, equals(new MM.Point(1, 1)) );
    });

    test('can do an inverse transform', () {
      var t = new MM.Transformation(0, 1, 0, 1, 0, 0);
      var p = new MM.Point(0, 1);

      var p_ = t.transform(p);
      var p__ = t.untransform(p_);

      expect(p, equals(new MM.Point(0, 1)) );
      expect(p_, equals(new MM.Point(1, 0)) );
      expect(p__, equals(new MM.Point(0, 1)) );
    });

    test('can do an addition transform', () {
      var t = new MM.Transformation(1, 0, 1, 0, 1, 1);
      var p = new MM.Point(0, 0);

      var p_ = t.transform(p);
      var p__ = t.untransform(p_);

      expect(p, equals(new MM.Point(0, 0)) );
      expect(p_, equals(new MM.Point(1,  1)) );
      expect(p__, equals(new MM.Point(0, 0)) );
    });

  });
}
