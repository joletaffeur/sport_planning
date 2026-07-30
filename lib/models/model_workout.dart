import 'model_exercise.dart';
import 'package:sport_planning/models/week_day.dart';

import 'package:hive/hive.dart';

part 'model_workout.g.dart';

@HiveType(typeId: 0)
class ModelWorkout {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<ModelExercise> exercises;

  @HiveField(2)
  List<WeekDay> days;

  ModelWorkout({
    this.name = '',
    List<ModelExercise>? exercises,
    List<WeekDay>? days,
  }) : exercises = exercises ?? [],
       days = days ?? [];
}