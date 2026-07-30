import 'package:drift/drift.dart';

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer()();
  TextColumn get name => text()();
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();
  IntColumn get rest => integer()();
}