import 'package:flutter/material.dart';

import 'package:sport_planning/models/week_day.dart';
import 'package:sport_planning/repositories/workout_repository.dart';
import 'package:sport_planning/models/model_workout.dart';
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

  String getDayName(WeekDay day) {
    switch (day) {
      case WeekDay.monday:
        return "Lundi";
      case WeekDay.tuesday:
        return "Mardi";
      case WeekDay.wednesday:
        return "Mercredi";
      case WeekDay.thursday:
        return "Jeudi";
      case WeekDay.friday:
        return "Vendredi";
      case WeekDay.saturday:
        return "Samedi";
      case WeekDay.sunday:
        return "Dimanche";
    }
  }

  @override
  void initState() {
    super.initState();
    workout = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 5,
          ),
        ),
        title: Text(
            "Detail - ${workout.name}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
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
      body: ListView(
        children: [

          // Les exercices
          for (final exercise in workout.exercises)
            Card(
              margin: const EdgeInsets.all(8),
              color: Color.fromARGB(255, 32, 32, 32),
              elevation: 8,
              shadowColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: ListTile(
                title: Text(
                  exercise.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${exercise.sets} séries • "
                  "${exercise.reps} répétitions • "
                  "${exercise.rest}s repos",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Programme de la semaine",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 32, 32, 32),
            elevation: 8,
            shadowColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                for (final day in WeekDay.values)
                  CheckboxListTile(
                    title: Text(
                      getDayName(day),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    value: workout.days.contains(day),

                    onChanged: (checked) async {
                      setState(() {
                        if (checked == true) {
                          if (!workout.days.contains(day)) {
                            workout.days.add(day);
                          }
                        } else {
                          workout.days.remove(day);
                        }
                      });

                      await widget.repository.updateWorkout(
                        widget.index,
                        workout,
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      )

    );

  }
}