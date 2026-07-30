# TodayWorkoutScreen

## Description

Le fichier `today_workout_screen.dart` contient le widget `TodayWorkoutScreen`, chargé d'afficher les séances prévues pour la journée.

Lors de son ouverture, l'écran détermine automatiquement le jour actuel puis recherche toutes les séances programmées pour ce jour. Chaque séance est affichée avec la liste de ses exercices ainsi qu'un bouton permettant de la valider (fonctionnalité prévue pour une évolution future).

Cet écran permet à l'utilisateur de connaître rapidement les entraînements qu'il doit réaliser aujourd'hui.

---

# Fonctionnement

`TodayWorkoutScreen` est un `StatefulWidget`.

À chaque construction de l'écran :

1. le jour actuel est déterminé grâce à la méthode `getToday()`;
2. toutes les séances enregistrées sont récupérées depuis le `WorkoutRepository`;
3. seules les séances programmées pour aujourd'hui sont conservées ;
4. ces séances sont affichées dans une liste.

Si aucune séance n'est programmée, un message est affiché à la place de la liste.

---

# Structure du widget

## TodayWorkoutScreen

Widget principal représentant la page des séances du jour.

### Paramètres

### `repository`

```dart
final WorkoutRepository repository;
```

Repository utilisé pour accéder aux séances enregistrées dans la base de données Hive.

---

## _TodayWorkoutScreenState

Classe responsable de la logique et de l'affichage de la page.

Elle détermine le jour courant et filtre les séances correspondantes.

---

# Méthodes

## getToday()

```dart
WeekDay getToday()
```

Retourne le jour actuel sous la forme de l'énumération `WeekDay`.

La méthode utilise :

```dart
DateTime.now().weekday
```

puis convertit la valeur obtenue en un élément de l'énumération.

Exemple :

- `1` → `WeekDay.monday`
- `5` → `WeekDay.friday`
- `7` → `WeekDay.sunday`

Cette méthode permet d'utiliser le même type de données que celui stocké dans les objets `ModelWorkout`.

---

# Sélection des séances

Les séances du jour sont obtenues avec le code suivant :

```dart
widget.repository
    .getWorkouts()
    .where((workout) => workout.days.contains(today))
    .toList();
```

Cette opération :

- récupère toutes les séances ;
- vérifie si le jour actuel est présent dans la liste `days` de chaque séance ;
- crée une nouvelle liste contenant uniquement les séances prévues aujourd'hui.

---

# Interface utilisateur

L'écran est composé de deux affichages possibles.

## Aucun entraînement prévu

Si aucune séance n'est programmée, un message est affiché :

```
Aucune séance prévue aujourd'hui
```

---

## Liste des séances

Lorsque des séances sont disponibles, elles sont affichées dans un `ListView`.

Chaque séance est représentée par une `Card` contenant :

- le nom de la séance ;
- la liste complète des exercices ;
- un bouton de validation.

---

# Affichage des exercices

Chaque exercice est présenté dans une carte secondaire.

Les informations affichées sont :

- le nom de l'exercice ;
- le nombre de séries ;
- le nombre de répétitions ;
- le temps de repos.

Ainsi, l'utilisateur peut consulter l'intégralité de sa séance sans avoir à ouvrir une autre page.

---

# Validation d'une séance

Chaque séance possède un bouton :

```
Valider la séance
```

Pour le moment, ce bouton ne contient aucune logique métier.

Il est prévu pour accueillir une fonctionnalité future permettant par exemple :

- de marquer une séance comme terminée ;
- d'enregistrer un historique des entraînements ;
- de suivre la progression de l'utilisateur.

---

# Dépendances

Ce fichier utilise les éléments suivants :

- `ModelWorkout`
  - représente une séance complète.

- `WeekDay`
  - énumération représentant les jours de la semaine.

- `WorkoutRepository`
  - fournit l'accès aux séances enregistrées dans Hive.

- Flutter Material
  - fournit les composants graphiques (`Scaffold`, `Card`, `ListView`, `ElevatedButton`, etc.).

---

# Exemple d'utilisation

Depuis `HomeScreen` :

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TodayWorkoutScreen(
      repository: repository,
    ),
  ),
);
```

L'écran reçoit uniquement le `WorkoutRepository`, ce qui lui permet de récupérer les séances correspondant au jour actuel.

---

# Remarques

- Le jour est déterminé automatiquement à partir de la date du système.
- Le filtrage des séances est réalisé localement à partir des données enregistrées dans Hive.
- L'écran ne modifie pas les données ; il est uniquement destiné à la consultation des entraînements du jour.
- La présence du bouton de validation prépare l'application à l'ajout de fonctionnalités de suivi des séances dans les prochaines versions.