
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:sport_planning/repositories/workout_repository.dart';
import 'package:sport_planning/models/week_day.dart';
import 'models/model_workout.dart';
import 'models/model_exercise.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(WeekDayAdapter());
  Hive.registerAdapter(ModelWorkoutAdapter());
  Hive.registerAdapter(ModelExerciseAdapter());

  final box = await Hive.openBox<ModelWorkout>("workouts");

  print("Box name: ${box.name}");
  print("Box length: ${box.length}");

  final repository = WorkoutRepository(box);


  runApp(
    MainApp(
      repository: repository,
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.repository});

  final WorkoutRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        repository: repository
      ),
    );
  }
}

class addExercice extends StatelessWidget {
  const addExercice({super.key, required this.onPressed});

  final void Function(void) onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // On ajoutera l'ouverture de la page ici
      },
      child: const Icon(Icons.add),
    );
  }
}