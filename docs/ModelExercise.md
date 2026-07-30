# ModelExercise

## Description

Le fichier `model_exercise.dart` définit la classe `ModelExercise`, qui représente un exercice individuel au sein d'une séance d'entraînement.

Chaque exercice contient les informations nécessaires à son exécution : son nom, le nombre de séries, le nombre de répétitions et le temps de repos.

Les objets `ModelExercise` sont utilisés dans les séances (`ModelWorkout`) et sont enregistrés dans la base de données locale grâce à Hive.

---

# Fonctionnement

Chaque instance de `ModelExercise` représente un exercice unique.

Plusieurs exercices peuvent être regroupés dans une même séance (`ModelWorkout`).

Lors de la création ou de la modification d'une séance, les valeurs de chaque exercice sont saisies par l'utilisateur puis enregistrées dans Hive.

---

# Attributs

## name

```dart
String name;
```

Nom de l'exercice.

Exemple :

```text
Développé couché
```

ou

```text
Squat
```

---

## sets

```dart
int sets;
```

Nombre de séries à effectuer.

Exemple :

```text
4
```

---

## reps

```dart
int reps;
```

Nombre de répétitions par série.

Exemple :

```text
10
```

---

## rest

```dart
int rest;
```

Temps de repos entre les séries, exprimé en secondes.

Exemple :

```text
90
```

correspond à 90 secondes de repos.

---

# Constructeur

```dart
ModelExercise(...)
```

Le constructeur initialise les différents champs de l'exercice.

Des valeurs par défaut sont définies afin de faciliter la création d'un nouvel exercice.

Exemple :

```dart
final exercise = ModelExercise();
```

Le résultat sera :

- name = ""
- sets = 0
- reps = 0
- rest = 0

Il est également possible d'initialiser directement toutes les informations :

```dart
final exercise = ModelExercise(
  name: "Squat",
  sets: 4,
  reps: 8,
  rest: 120,
);
```

---

# Annotations Hive

La classe est annotée avec :

```dart
@HiveType(typeId: 1)
```

afin de permettre sa sérialisation par Hive.

Chaque attribut possède un identifiant unique :

```dart
@HiveField(0)
String name;
```

```dart
@HiveField(1)
int sets;
```

```dart
@HiveField(2)
int reps;
```

```dart
@HiveField(3)
int rest;
```

Ces identifiants sont utilisés par Hive pour enregistrer les données dans la base locale et ne doivent pas être modifiés après la mise en production.

---

# Utilisation dans le projet

La classe `ModelExercise` est utilisée dans plusieurs parties de l'application :

- `ModelWorkout`
  - pour constituer la liste des exercices d'une séance.

- `ExerciseForm`
  - pour créer ou modifier un exercice.

- `WorkoutDetailScreen`
  - pour afficher les exercices d'une séance.

- `TodayWorkoutScreen`
  - pour afficher les exercices des séances prévues aujourd'hui.

---

# Exemple d'utilisation

Créer un exercice :

```dart
final exercise = ModelExercise(
  name: "Développé militaire",
  sets: 4,
  reps: 10,
  rest: 90,
);
```

Ajouter cet exercice à une séance :

```dart
workout.exercises.add(exercise);
```

---

# Dépendances

Ce fichier dépend uniquement de :

- `Hive`
  - pour permettre la sauvegarde et la lecture des objets dans la base de données locale.

Il est utilisé principalement par :

- `ModelWorkout`
- `ExerciseForm`
- `WorkoutDetailScreen`
- `TodayWorkoutScreen`

---

# Remarques

- Cette classe représente un seul exercice.
- Plusieurs objets `ModelExercise` peuvent être regroupés dans une même séance (`ModelWorkout`).
- Les valeurs par défaut facilitent la création d'un nouvel exercice avant que l'utilisateur ne renseigne les informations.
- Grâce aux annotations Hive, les exercices sont enregistrés automatiquement avec les séances dans la base de données locale.