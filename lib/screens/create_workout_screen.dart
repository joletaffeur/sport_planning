
import 'package:flutter/material.dart';
import 'package:sport_planning/widgets/exerciseForm.dart';
import 'package:sport_planning/models/exercise.dart';
import 'package:sport_planning/models/workout.dart';
import 'package:sport_planning/services/workout_storage.dart';


class CreateWorkoutScreen extends StatefulWidget {

  const CreateWorkoutScreen({super.key, this.workout});

  final ModelWorkout? workout;

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();

}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {

  final workoutNameController = TextEditingController();

  final List<ModelExercise> exercises = [];
  
  @override
  void initState() {
    super.initState();

    if (widget.workout == null) {
      addExerciseForm();
    } else {
      for (int i = 0; i < widget.workout!.exercises.length; i++) {
        exercises.add(widget.workout!.exercises[i]);
      }

      workoutNameController.text = widget.workout!.name;
    }
  }

  void addExerciseForm() {
    setState(() {
      exercises.add(ModelExercise());
    });
  }

  void createWorkout() { // methode pour sauvgarder le workout

    final workout = ModelWorkout(
      name: workoutNameController.text == '' ? "default" : workoutNameController.text,
      exercises: exercises,
    );
    if (widget.workout != null) {
      WorkoutStorage.removeWorkout(widget.workout!);
    }
    WorkoutStorage.addWorkout(workout);
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
                  child: widget.workout == null ? const Text("Créer la séance",) : Text("Sauvgarder la modification"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
