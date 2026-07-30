# WorkoutRepository

## Description

Le fichier `workout_repository.dart` contient la classe `WorkoutRepository`, responsable de toutes les interactions avec la base de données locale Hive concernant les séances d'entraînement.

Cette classe joue le rôle d'intermédiaire entre l'interface utilisateur et le stockage des données. Les différents écrans de l'application ne manipulent jamais directement la base de données : ils utilisent les méthodes fournies par ce repository.

Cette organisation facilite la maintenance du projet et centralise toutes les opérations liées aux séances.

---

# Fonctionnement

`WorkoutRepository` reçoit une instance de `Box<ModelWorkout>` lors de sa création.

Toutes les opérations (lecture, ajout, modification et suppression) sont réalisées à travers cette boîte Hive.

Le repository ne contient aucune logique d'affichage ; son unique responsabilité est la gestion des données.

---

# Structure de la classe

## WorkoutRepository

Classe permettant de manipuler les objets `ModelWorkout` enregistrés dans Hive.

---

# Attributs

## box

```dart
final Box<ModelWorkout> box;
```

Représente la boîte Hive contenant toutes les séances enregistrées.

Chaque élément de cette boîte correspond à une instance de `ModelWorkout`.

---

# Constructeur

```dart
WorkoutRepository(this.box);
```

Le constructeur reçoit une boîte Hive déjà ouverte.

Cette approche permet de réutiliser facilement le repository dans toute l'application.

---

# Méthodes

## addWorkout()

```dart
Future<void> addWorkout(ModelWorkout workout)
```

Ajoute une nouvelle séance dans la base de données.

### Paramètre

- `workout` : séance à enregistrer.

### Fonctionnement

La méthode utilise :

```dart
box.add(workout);
```

Hive attribue automatiquement un nouvel emplacement à la séance.

---

## getWorkouts()

```dart
List<ModelWorkout> getWorkouts()
```

Retourne la liste de toutes les séances enregistrées.

### Retour

```dart
List<ModelWorkout>
```

La liste est obtenue grâce à :

```dart
box.values.toList();
```

Cette méthode est principalement utilisée par `HomeScreen` et `TodayWorkoutScreen`.

---

## getWorkout()

```dart
ModelWorkout getWorkout(int index)
```

Retourne une séance à partir de son indice dans la boîte Hive.

### Paramètre

- `index` : position de la séance.

### Retour

```dart
ModelWorkout
```

Cette méthode est utilisée après une modification afin de récupérer la version la plus récente de la séance enregistrée.

---

## updateWorkout()

```dart
Future<void> updateWorkout(int index, ModelWorkout workout)
```

Remplace une séance existante par une nouvelle version.

### Paramètres

- `index` : position de la séance.
- `workout` : nouvelle version de la séance.

### Fonctionnement

La méthode utilise :

```dart
box.putAt(index, workout);
```

Les anciennes données sont remplacées par les nouvelles.

---

## deleteWorkout()

```dart
Future<void> deleteWorkout(int index)
```

Supprime une séance de la base de données.

### Paramètre

- `index` : position de la séance à supprimer.

### Fonctionnement

La méthode utilise :

```dart
box.deleteAt(index);
```

La séance est définitivement retirée de Hive.

---

# Dépendances

Ce fichier dépend des éléments suivants :

- `Hive`
  - assure le stockage local des données.

- `ModelWorkout`
  - représente les séances enregistrées dans la base.

Les principaux utilisateurs de ce repository sont :

- `HomeScreen`
- `CreateWorkoutScreen`
- `WorkoutDetailScreen`
- `TodayWorkoutScreen`

---

# Exemple d'utilisation

Création du repository :

```dart
final repository = WorkoutRepository(box);
```

Ajout d'une séance :

```dart
await repository.addWorkout(workout);
```

Lecture de toutes les séances :

```dart
final workouts = repository.getWorkouts();
```

Modification :

```dart
await repository.updateWorkout(index, workout);
```

Suppression :

```dart
await repository.deleteWorkout(index);
```

---

# Remarques

- Le repository centralise toutes les opérations d'accès aux données, ce qui évite que plusieurs écrans manipulent directement Hive.
- Les méthodes de modification (`addWorkout`, `updateWorkout` et `deleteWorkout`) sont asynchrones afin de garantir la bonne exécution des opérations de stockage.
- Cette architecture facilite l'évolution du projet : si le système de stockage change (par exemple vers SQLite ou une base distante), seule l'implémentation du repository devra être modifiée, sans impacter les écrans de l'application.