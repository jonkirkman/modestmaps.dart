
part of modestmaps;

class Transformation {
  // this is basically a 3D matrix
  // perhaps I should use `mat3`
  num ax = 0, ay = 0, at = 0,
         bx = 0, by = 0, bt = 0,
         cx = 0, cy = 0, ct = 0;

	Transformation(this.ax, this.bx, this.cx, this.ay, this.by, this.cy);


	Point transform(Point point) {
	  return new Point(this.ax * point.x + this.bx * point.y + this.cx,
        this.ay * point.x + this.by * point.y + this.cy);
	}

	Point untransform(Point point) {
	  return new Point(
	      (point.x * this.by - point.y * this.bx - this.cx * this.by + this.cy * this.bx) / (this.ax * this.by - this.ay * this.bx),
        (point.x * this.ay - point.y * this.ax - this.cx * this.ay + this.cy * this.ax) / (this.bx * this.ay - this.by * this.ax));
	}


	// Generates a transform based on three pairs of points,
	// a1 -> a2, b1 -> b2, c1 -> c2.
	static Transformation deriveTransformation(a1x, a1y, a2x, a2y, b1x, b1y, b2x, b2y, c1x, c1y, c2x, c2y) {
	  var x = linearSolution(a1x, a1y, a2x, b1x, b1y, b2x, c1x, c1y, c2x);
    var y = linearSolution(a1x, a1y, a2y, b1x, b1y, b2y, c1x, c1y, c2y);
    return new Transformation(x[0], x[1], x[2], y[0], y[1], y[2]);
	}

	// Solves a system of linear equations.
	//
	//     t1 = (a * r1) + (b + s1) + c
	//     t2 = (a * r2) + (b + s2) + c
	//     t3 = (a * r3) + (b + s3) + c
	//
	// r1 - t3 are the known values.
	// a, b, c are the unknowns to be solved.
	// returns the a, b, c coefficients.
	static List linearSolution(r1, s1, t1, r2, s2, t2, r3, s3, t3) {
      var a = (((t2 - t3) * (s1 - s2)) - ((t1 - t2) * (s2 - s3))) / (((r2 - r3) * (s1 - s2)) - ((r1 - r2) * (s2 - s3)));
      var b = (((t2 - t3) * (r1 - r2)) - ((t1 - t2) * (r2 - r3))) / (((s2 - s3) * (r1 - r2)) - ((s1 - s2) * (r2 - r3)));
      var c = t1 - (r1 * a) - (s1 * b);
      return [ a, b, c ];
	}

}
