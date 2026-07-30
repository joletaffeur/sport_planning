import 'package:flutter/material.dart';
import 'package:sport_planning/models/model_exercise.dart';


class ExerciseForm extends StatefulWidget {

  const ExerciseForm({
    super.key,
    required this.exercise,
    required this.onDelete,
  });

  final ModelExercise exercise; // exercise vide au depart puis changer avec le temps
  final VoidCallback onDelete;

  @override
  State<ExerciseForm> createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {

  @override
  Widget build(BuildContext context) {

    print("recostuit");
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: const BorderSide(
          color: Colors.blue,
          width: 2
        )
      ),

      child: Padding(

        padding: const EdgeInsets.all(12),

        child: Column(

          children: [

            Row( // la ligne de l'exercice genre le titre quoi
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [                
                const Text(
                  "Exercice",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: widget.onDelete, // boutton supprimer qui appele la labdas onDelete
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            TextFormField(
              initialValue: widget.exercise.name,
              decoration: const InputDecoration(
                labelText: "Nom de l'exercice",
              ),
              onChanged: (value) {
                widget.exercise.name = value;
              },
            ),


            TextFormField(
              initialValue: widget.exercise.sets == 0 ? '' : widget.exercise.sets.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nombre de séries",
              ),
              onChanged: (value) {
                widget.exercise.sets = int.tryParse(value) ?? 0;
              },
            ),


            TextFormField(
              initialValue: widget.exercise.reps == 0 ? '' : widget.exercise.reps.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Répétitions",
              ),
              onChanged: (value) {
                widget.exercise.reps = int.tryParse(value) ?? 0;
              },
            ),


            TextFormField(
              initialValue: widget.exercise.rest == 0 ? '' : widget.exercise.rest.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Temps de repos",
              ),
              onChanged: (value) {
                widget.exercise.rest = int.tryParse(value) ?? 0;
              },
            ),
          ],
        ),
      ),
    );
  }
}