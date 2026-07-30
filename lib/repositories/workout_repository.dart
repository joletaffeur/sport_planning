import 'package:hive/hive.dart';
import '../models/model_workout.dart';

class WorkoutRepository {

  final Box<ModelWorkout> box;
  WorkoutRepository(this.box);

  Future<void> addWorkout(ModelWorkout workout) async {
    await box.add(workout);
  }

  List<ModelWorkout> getWorkouts() {
    return box.values.toList();
  }

  ModelWorkout getWorkout(int index) {
    return box.getAt(index)!;
  }

  Future<void> deleteWorkout(int index) async {
    await box.deleteAt(index);
  }

  Future<void> updateWorkout(int index, ModelWorkout workout,) async {
    await box.putAt(index, workout);
  }
}