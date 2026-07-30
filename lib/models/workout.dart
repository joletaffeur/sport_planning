import 'exercise.dart';

class ModelWorkout {
  final int? id;
  String name;
  List<ModelExercise> exercises;

  ModelWorkout({
    this.id,
    required this.name,
    required this.exercises,
  });
}