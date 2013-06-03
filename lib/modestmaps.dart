/**
 * Modest Maps ported to Dart
 */

library modestmaps;

import 'dart:html';
import 'dart:math';
import 'dart:uri';
import 'package:vector_math/vector_math.dart';

part 'src/utils.dart';
part 'src/point.dart';
part 'src/coordinate.dart';
part 'src/location.dart';
part 'src/extents.dart';
part 'src/transformation.dart';
part 'src/projection.dart';
part 'src/provider.dart'; // parse tile-provider URLs, etc.

part 'src/mouse.dart';
part 'src/touch.dart';

part 'src/callbacks.dart';
part 'src/requests.dart';

part 'src/layer.dart';
part 'src/map.dart';
part 'src/convenience.dart';
