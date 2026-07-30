import 'model_exercise.dart';
import 'package:hive/hive.dart';

part 'model_workout.g.dart';

@HiveType(typeId: 0)
class ModelWorkout {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<ModelExercise> exercises;

  ModelWorkout({
    this.name = '',
    List<ModelExercise>? exercises,
  }) : exercises = exercises ?? [];
}