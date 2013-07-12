
part of modestmaps;

// An abstract class / interface for projections
class Projection {
  double zoom;
  Transformation transformation = new Transformation(1, 0, 0, 0, 1, 0);

  Projection(this.zoom);

  Point rawProject(Point point) => point.copy();
  Point rawUnproject(Point point) => point.copy();

  Point project(Point point) {
    point = rawProject(point);
    point = transformation.transform(point);
    return point;
  }
  Point unproject(Point point) {
    point = transformation.untransform(point);
    point = rawUnproject(point);
    return point;
  }

  /// Convert a Location to a Coordinate using the projection
  Coordinate locationCoordinate(Location location) {
    Point point = new Point(PI * location.lon / 180.0, PI * location.lat / 180.0);
    point = project(point);
    return new Coordinate(point.y, point.x, zoom);
  }
  /// Convert a Coordinate to a Location using the projection
  Location coordinateLocation(Coordinate coordinate) {
    coordinate = coordinate.zoomTo(zoom);
    Point point = new Point(coordinate.column, coordinate.row);
    point = unproject(point);
    return new Location(180.0 * point.y / PI, 180.0 * point.x / PI);
  }
}

class LinearProjection extends Projection {
  LinearProjection(z) : super(z);
}

class MercatorProjection extends Projection {
  MercatorProjection(z) : super(z);

  Point rawProject(Point point) => new Point(point.x, log(tan(0.25 * PI + 0.5 * point.y)));
  Point rawUnproject(Point point) => new Point(point.x, 2 * atan(pow(E, point.y)) - 0.5 * PI);
}
