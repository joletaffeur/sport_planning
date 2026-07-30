# ModelWorkout

## Description

Le fichier `model_workout.dart` définit la classe `ModelWorkout`, qui représente une séance d'entraînement complète.

Une séance est composée d'un nom, d'une liste d'exercices et d'une liste de jours de la semaine sur lesquels elle est programmée.

Cette classe constitue le modèle principal de l'application. Les objets `ModelWorkout` sont enregistrés dans la base de données locale grâce à Hive.

---

# Fonctionnement

Chaque instance de `ModelWorkout` représente une séance unique.

Lors de la création d'une séance, l'utilisateur choisit :

- un nom ;
- plusieurs exercices ;
- les jours de la semaine où la séance doit être réalisée.

Les informations sont ensuite enregistrées dans Hive puis réutilisées dans les différents écrans de l'application.

---

# Attributs

## name

```dart
String name;
```

Nom de la séance.

Exemple :

```text
Push
```

ou

```text
Jambes
```

---

## exercises

```dart
List<ModelExercise> exercises;
```

Liste des exercices composant la séance.

Chaque élément est un objet `ModelExercise` contenant :

- le nom de l'exercice ;
- le nombre de séries ;
- le nombre de répétitions ;
- le temps de repos.

---

## days

```dart
List<WeekDay> days;
```

Liste des jours de la semaine pendant lesquels la séance doit être effectuée.

Une séance peut être programmée sur plusieurs jours.

Exemple :

```dart
[
  WeekDay.monday,
  WeekDay.thursday,
]
```

---

# Constructeur

```dart
ModelWorkout(...)
```

Le constructeur initialise les différents champs de la séance.

Si aucune liste d'exercices ou de jours n'est fournie, des listes vides sont automatiquement créées.

Exemple :

```dart
final workout = ModelWorkout(
  name: "Push",
);
```

Le résultat sera :

- nom = "Push"
- exercises = []
- days = []

---

# Annotations Hive

La classe est annotée avec :

```dart
@HiveType(typeId: 0)
```

ce qui permet à Hive de sérialiser les objets `ModelWorkout`.

Chaque propriété possède un identifiant unique :

```dart
@HiveField(0)
String name;
```

```dart
@HiveField(1)
List<ModelExercise> exercises;
```

```dart
@HiveField(2)
List<WeekDay> days;
```

Ces identifiants sont utilisés pour enregistrer les données dans la base locale.

Ils ne doivent pas être modifiés après la mise en production de l'application.

---

# Utilisation dans le projet

La classe `ModelWorkout` est utilisée dans la majorité des écrans de l'application :

- `CreateWorkoutScreen`
  - création et modification d'une séance.

- `WorkoutDetailScreen`
  - affichage des informations d'une séance et programmation des jours.

- `HomeScreen`
  - affichage de toutes les séances enregistrées.

- `TodayWorkoutScreen`
  - affichage des séances prévues pour la journée.

- `WorkoutRepository`
  - ajout, lecture, modification et suppression des séances dans Hive.

---

# Exemple d'utilisation

Créer une séance :

```dart
final workout = ModelWorkout(
  name: "Push",
  exercises: [
    ModelExercise(
      name: "Développé couché",
      sets: 4,
      reps: 10,
      rest: 90,
    ),
  ],
  days: [
    WeekDay.monday,
    WeekDay.thursday,
  ],
);
```

---

# Dépendances

Ce fichier dépend de :

- `Hive`
  - pour la sauvegarde des données.

- `ModelExercise`
  - pour représenter les exercices.

- `WeekDay`
  - pour représenter les jours de la semaine.

Il est utilisé par l'ensemble de l'application pour manipuler les séances d'entraînement.

---

# Remarques

- Une séance peut contenir un nombre quelconque d'exercices.
- Une séance peut être programmée sur plusieurs jours de la semaine.
- Les listes sont automatiquement initialisées lorsqu'aucune valeur n'est fournie afin d'éviter les erreurs liées aux valeurs nulles.
- Cette classe constitue le modèle central de l'application et est stockée directement dans la base de données locale grâce à Hive.