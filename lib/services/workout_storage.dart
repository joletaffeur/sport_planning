import '../models/model_workout.dart';

class WorkoutStorage {

  static final List<ModelWorkout> workouts = [];

  static void addWorkout(ModelWorkout workout) {
    workouts.add(workout);
  }

  static void removeWorkout(ModelWorkout workout) {
    workouts.remove(workout);
  }
}