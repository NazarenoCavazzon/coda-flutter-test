import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_coda/app/app.dart';
import 'package:test_coda/bootstrap.dart';
import 'package:test_coda/common/box_keys.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(BoxKeys.token);
  await bootstrap(() => const App());
}
