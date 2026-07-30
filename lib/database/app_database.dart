import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:sport_planning/database/table/exercises.dart';
import 'package:sport_planning/database/table/workout.dart';

// il faut genere un fichier avec la commande 'dart run build_runner build'
// en gros c'est des methode, class ... en plus qui sont genere avec ce fichier et la class _$appdatabase
part 'app_database.g.dart'; 

@DriftDatabase(
  tables: [
    Workouts,
    Exercises,
  ], // tout les table avec les quel je travaille
)

// la class qui gerer la connection a tout les table de la db
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()); // on ouvre une connection avec la db

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() { // la connextion avec la db
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      p.join(directory.path, 'sport_planning.sqlite'), // la db
    );

    return NativeDatabase(file);
  });
}