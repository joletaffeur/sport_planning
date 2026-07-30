class ModelExercise {
  final int? id;
  String name;
  int sets;
  int reps;
  int rest;

  ModelExercise({
    this.id,
    this.name = '',
    this.sets = 0,
    this.reps = 0,
    this.rest = 0,
  }); // le constructeur permet de mettre a default les attribut pour les changer apres
}