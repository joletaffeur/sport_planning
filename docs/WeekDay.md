# WeekDay

## Description

Le fichier `week_day.dart` définit l'énumération `WeekDay`, utilisée pour représenter les jours de la semaine dans l'application.

Cette énumération permet d'associer une ou plusieurs séances d'entraînement à des jours précis. Elle remplace l'utilisation d'entiers (`1`, `2`, `3`, etc.), ce qui rend le code plus lisible, plus compréhensible et limite les erreurs de programmation.

Grâce aux annotations Hive, les valeurs de l'énumération peuvent être enregistrées directement dans la base de données locale.

---

# Fonctionnement

`WeekDay` est une énumération (`enum`) contenant les sept jours de la semaine.

Chaque valeur est annotée avec `@HiveField` afin que Hive puisse convertir automatiquement l'énumération lors de la sauvegarde et de la lecture des données.

Les objets `ModelWorkout` possèdent une liste de `WeekDay`, permettant de programmer une séance sur plusieurs jours.

---

# Structure de l'énumération

## WeekDay

```dart
enum WeekDay
```

Énumération représentant les sept jours de la semaine.

Les valeurs disponibles sont :

- `monday`
- `tuesday`
- `wednesday`
- `thursday`
- `friday`
- `saturday`
- `sunday`

---

# Annotations Hive

L'annotation :

```dart
@HiveType(typeId: 2)
```

indique à Hive qu'il s'agit d'un type sérialisable.

Chaque valeur possède également un identifiant unique :

```dart
@HiveField(0)
monday
```

Ces identifiants sont utilisés par Hive pour enregistrer les données dans la base locale.

**Important :** une fois l'application déployée, ces identifiants ne doivent plus être modifiés, sous peine de rendre les anciennes données incompatibles.

---

# Utilisation dans le projet

L'énumération `WeekDay` est principalement utilisée dans `ModelWorkout`.

Exemple :

```dart
List<WeekDay> days;
```

Cette liste contient les jours où une séance doit être effectuée.

Elle est également utilisée dans plusieurs écrans :

- `WorkoutDetailScreen`
  - pour afficher les cases à cocher des jours de la semaine.

- `TodayWorkoutScreen`
  - pour déterminer quelles séances doivent être affichées aujourd'hui.

---

# Exemple d'utilisation

Créer une liste contenant deux jours :

```dart
[
  WeekDay.monday,
  WeekDay.friday,
]
```

Vérifier si une séance est programmée un jour donné :

```dart
workout.days.contains(WeekDay.monday);
```

Ajouter un nouveau jour :

```dart
workout.days.add(WeekDay.saturday);
```

Supprimer un jour :

```dart
workout.days.remove(WeekDay.sunday);
```

---

# Dépendances

Ce fichier dépend uniquement de :

- `Hive`
  - pour permettre la sérialisation de l'énumération.

Il est utilisé par :

- `ModelWorkout`
- `WorkoutDetailScreen`
- `TodayWorkoutScreen`

---

# Remarques

- L'utilisation d'une énumération rend le code plus clair que l'utilisation de nombres entiers pour représenter les jours de la semaine.
- Les annotations Hive permettent de sauvegarder directement les valeurs de l'énumération dans la base de données sans conversion supplémentaire.
- Ce fichier sert uniquement à définir les jours de la semaine et ne contient aucune logique métier.
- L'ajout d'un nouveau jour ou la modification des identifiants `@HiveField` après la mise en production pourrait rendre les données existantes incompatibles avec les nouvelles versions de l'application.