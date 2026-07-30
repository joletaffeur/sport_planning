import 'package:flutter/material.dart';
import 'package:sport_planning/models/exercise.dart';
import 'package:sport_planning/services/workout_storage.dart';
import '../models/workout.dart';
import 'package:sport_planning/screens/create_workout_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key, required this.workout});

  final ModelWorkout workout;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Detail - ${widget.workout.name}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              WorkoutStorage.removeWorkout(widget.workout);
              Navigator.pop(context);
            },
          ),

          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.yellow,
            ),
            onPressed: () {
              Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context) => CreateWorkoutScreen(
                    workout: widget.workout,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.workout.exercises.length,
        itemBuilder: (context, index) {
          
          final ModelExercise exercise = widget.workout.exercises[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                exercise.name,
              ),

              subtitle: Text(
                "${exercise.sets} séries • "
                "${exercise.reps} répétitions • "
                "${exercise.rest}s repos",
              ),

            ),

          );
        },

      )

    );

  }
}