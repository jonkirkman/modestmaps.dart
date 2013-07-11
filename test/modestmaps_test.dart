
library modestmaps_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'package:modestmaps_dart/modestmaps.dart' as MM;


part 'src/point_test.dart';
part 'src/coordinate_test.dart';
part 'src/location_test.dart';
part 'src/extent_test.dart';
part 'src/transformation_test.dart';
// part 'src/projection_test.dart';
// part 'src/provider_test.dart';

main() {
  useVMConfiguration();

  point_test();
  coordinate_test();
  location_test();
  extent_test();
  transformation_test();
}