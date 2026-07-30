import 'package:flutter/material.dart';
import 'package:sport_planning/models/model_workout.dart';
import 'package:sport_planning/models/week_day.dart';
import 'package:sport_planning/repositories/workout_repository.dart';

class TodayWorkoutScreen extends StatefulWidget {
  const TodayWorkoutScreen({
    super.key,
    required this.repository,
  });

  final WorkoutRepository repository;

  @override
  State<TodayWorkoutScreen> createState() => _TodayWorkoutScreenState();
}


class _TodayWorkoutScreenState extends State<TodayWorkoutScreen> {


  WeekDay getToday() {
    switch (DateTime.now().weekday) {
      case 1:
        return WeekDay.monday;
      case 2:
        return WeekDay.tuesday;
      case 3:
        return WeekDay.wednesday;
      case 4:
        return WeekDay.thursday;
      case 5:
        return WeekDay.friday;
      case 6:
        return WeekDay.saturday;
      default:
        return WeekDay.sunday;
    }
  }


  @override
  Widget build(BuildContext context) {

    final WeekDay today = getToday();

    final List<ModelWorkout> workoutsToday =
        widget.repository
            .getWorkouts()
            .where((workout) => workout.days.contains(today))
            .toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aujourd'hui",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),


      body: workoutsToday.isEmpty
          ? const Center(
              child: Text(
                "Aucune séance prévue aujourd'hui",
              ),
            )

          : ListView.builder(
              itemCount: workoutsToday.length,

              itemBuilder: (context, index) {

                final workout = workoutsToday[index];

                return Card(
                  margin: const EdgeInsets.all(8),

                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          workout.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        for (final exercise in workout.exercises)
                          Card(
                            color: Colors.grey.shade200,
                            child: ListTile(
                              title: Text(
                                exercise.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              subtitle: Text(
                                "${exercise.sets} séries • "
                                "${exercise.reps} répétitions • "
                                "${exercise.rest}s repos",
                              ),
                            ),
                          ),

                        const SizedBox(height: 10),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // validation du workout plus tard
                            },
                            child: const Text(
                              "Valider la séance",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}