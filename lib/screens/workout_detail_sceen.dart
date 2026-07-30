import 'package:flutter/material.dart';
import 'package:sport_planning/models/model_exercise.dart';
import 'package:sport_planning/repositories/workout_repository.dart';
import '../models/model_workout.dart';
import 'package:sport_planning/screens/create_workout_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key, required this.workout, required this.repository, required this.index,});

  final ModelWorkout workout;
  final WorkoutRepository repository;
  final int index;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {

  late ModelWorkout workout;

  @override
  void initState() {
    super.initState();
    workout = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Detail - ${workout.name}",
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
            onPressed: () async {
              await widget.repository.deleteWorkout(widget.index);
              Navigator.pop(context);
            },
          ),

          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.yellow,
            ),
            onPressed: () async {
              await Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context) => CreateWorkoutScreen(
                    workout: workout,
                    repository: widget.repository,
                    index: widget.index,
                  ),
                ),
              );
              setState(() {
                workout = widget.repository.getWorkout(widget.index);
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (context, index) {
          
          final ModelExercise exercise = workout.exercises[index];

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