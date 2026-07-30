
import 'package:flutter/material.dart';
import 'package:sport_planning/widgets/exerciseForm.dart';
import 'package:sport_planning/models/model_exercise.dart';
import 'package:sport_planning/models/model_workout.dart';
import 'package:sport_planning/repositories/workout_repository.dart';


class CreateWorkoutScreen extends StatefulWidget {

  const CreateWorkoutScreen({super.key, required this.repository, this.workout, this.index});

  final ModelWorkout? workout;
  final WorkoutRepository repository;
  final int? index;
  

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();

}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {

  final workoutNameController = TextEditingController();

  final List<ModelExercise> exercises = [];
  
  @override
  void dispose() {
    workoutNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.workout == null) {
      addExerciseForm();
    } else {
      for (final exercise in widget.workout!.exercises) {
        exercises.add(
          ModelExercise(
            name: exercise.name,
            sets: exercise.sets,
            reps: exercise.reps,
            rest: exercise.rest,
          ),
        );
      }

      workoutNameController.text = widget.workout!.name;
    }
  }

  void addExerciseForm() {
    setState(() {
      exercises.add(ModelExercise());
    });
  }

  Future<void> createWorkout() async {
    final workout = ModelWorkout(
      name: workoutNameController.text == '' ? "default" : workoutNameController.text,
      exercises: exercises,
    );
    if (widget.index != null) {
      await widget.repository.updateWorkout(
        widget.index!,
        workout,
      );
    } else {
      await widget.repository.addWorkout(workout);
    }

    print("Box contient ${widget.repository.getWorkouts().length} séance(s)");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar( // la bar en haut là
        title: const Text(
          "Create Workout",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        foregroundColor: Colors.white,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 5,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
                bottom: 55,
              ),
              children: [
                TextField( // input pour le nom du workout
                  controller: workoutNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 32, 32, 32),

                    labelText: "Workout name",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),

                    )
                  ),
                ),
                for (int i = 0; i < exercises.length; i++) // reconstruit les formulaires des exercise
                  ExerciseForm(
                    key: ValueKey(exercises[i]),
                    exercise: exercises[i],
                    onDelete: () {
                      setState(() {
                        exercises.removeAt(i);
                      });
                    },
                  ),
                ElevatedButton( // ajoute un exercise vide
                  onPressed: addExerciseForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    "+ Ajouter un exercice",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton( // sauvgarde le wokout
                  onPressed: createWorkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white
                  ),
                  child: widget.index == null ? const Text(
                    "Créer la séance",
                  ) :
                  Text(
                    "Sauvgarder la modification"
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
