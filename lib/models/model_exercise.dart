import 'package:hive/hive.dart';

part 'model_exercise.g.dart';

@HiveType(typeId: 1)
class ModelExercise {

  @HiveField(0)
  String name;

  @HiveField(1)
  int sets;

  @HiveField(2)
  int reps;

  @HiveField(3)
  int rest;

  ModelExercise({
    this.name = '',
    this.sets = 0,
    this.reps = 0,
    this.rest = 0,
  });
}