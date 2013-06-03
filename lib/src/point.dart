
part of modestmaps;

class Point {
  num x, y;

  Point(this.x, this.y);

  String toString() => "(${this.x.toStringAsFixed(3)}, ${this.y.toStringAsFixed(3)})";

  Point copy() => new Point(this.x, this.y);

  // Get the euclidean distance between two points
  static num distance(Point p1, Point p2) {
    return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2));
  }

  // Get a point between two other points, biased by `t`.
  static Point interpolate(Point p1, Point p2, t) {
    return new Point(p1.x + (p2.x - p1.x) * t, p1.y + (p2.y - p1.y) * t);
  }

}
