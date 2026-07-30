import 'package:flutter/material.dart';
import 'package:sport_planning/models/model_workout.dart';
import 'package:sport_planning/screens/workout_detail_sceen.dart';
import 'package:sport_planning/repositories/workout_repository.dart';
import 'package:sport_planning/screens/today_workout_screen.dart';
import 'create_workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository});

  final WorkoutRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes séances",
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

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          FloatingActionButton(
            heroTag: "create",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateWorkoutScreen(
                    repository: widget.repository,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            child: const Icon(Icons.add),
          ),

          FloatingActionButton(
            heroTag: "today",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodayWorkoutScreen(
                    repository: widget.repository,
                  ),
                ),
              );
            },
            child: const Icon(Icons.calendar_today),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: FutureBuilder(
        future: Future.value(widget.repository.getWorkouts()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final workouts = snapshot.data ?? [];
          print("Workouts lus : ${workouts.length}");

          return ListView.builder(
            itemCount: workouts.length,

            itemBuilder: (context, index) {

              final ModelWorkout workout = workouts[index];


              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),

                child: ListTile(
                  tileColor: Colors.orange,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  title: Text(
                    workout.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    "${workout.exercises.length} exercises",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailScreen(
                          workout: workout,
                          repository: widget.repository,
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}