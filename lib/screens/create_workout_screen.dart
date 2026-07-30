
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

      appBar: AppBar( // la bar en haut là
        title: const Text(
          "Create Workout",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                TextField( // input pour le nom du workout
                  controller: workoutNameController,
                  decoration: InputDecoration(
                    labelText: "Workout name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)), 
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
                  child: const Text(
                    "+ Ajouter un exercice",
                  ),
                ),
                ElevatedButton( // sauvgarde le wokout
                  onPressed: createWorkout,
                  child: widget.index == null ? const Text("Créer la séance",) : Text("Sauvgarder la modification"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
