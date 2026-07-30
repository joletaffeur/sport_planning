
import 'package:sport_planning/database/app_database.dart';
import 'package:sport_planning/models/exercise.dart';
import 'package:sport_planning/models/workout.dart';
import 'package:drift/drift.dart';

class WorkoutRepository {
  final AppDatabase database;

  WorkoutRepository(this.database);

  Future<void> addWorkout(ModelWorkout workout) async {
    final workoutId = await database.into(database.workouts).insert(
      WorkoutsCompanion(
        name: Value(workout.name),
      ),
    );
    for (final exercise in workout.exercises) {
      await database.into(database.exercises).insert(
        ExercisesCompanion(
          workoutId: Value(workoutId),
          name: Value(exercise.name),
          sets: Value(exercise.sets),
          reps: Value(exercise.reps),
          rest: Value(exercise.rest),
        ),
      );
    }
  }

  Future<List<ModelWorkout>> getWorkouts() async {
    final rows = await database.select(database.workouts).get();
    final List<ModelWorkout> workouts = [];

    for (final row in rows) {

      final List<ModelExercise> exercises = await getExercises(row.id);

      workouts.add(
        ModelWorkout(
          id: row.id,
          name: row.name,
          exercises: exercises
        ),
      );
    }
  
    return workouts;
  }

  Future<List<ModelExercise>> getExercises(int workoutId) async {
    final rows = await (database.select(database.exercises)
      ..where((table) => table.workoutId.equals(workoutId)))
    .get();
    final List<ModelExercise> exercises = [];

    for (final row in rows) {
      exercises.add(
      ModelExercise(
        id: row.id,
        name: row.name,
        sets: row.sets,
        reps: row.reps,
        rest: row.rest,
        ),
      );
    }
    return exercises;
  }
}