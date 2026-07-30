import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


LazyDatabase createConnection() {
  return LazyDatabase(() async {

    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      p.join(
        directory.path,
        'sport_planning.sqlite',
      ),
    );

    return NativeDatabase(file);
  });
}