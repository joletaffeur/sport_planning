
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/model_workout.dart';
import 'models/model_exercise.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ModelWorkoutAdapter());
  Hive.registerAdapter(ModelExerciseAdapter());

  await Hive.openBox<ModelWorkout>("workouts");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
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