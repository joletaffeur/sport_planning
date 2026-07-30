# WorkoutDetailScreen

## Description

Le fichier `workout_detail_screen.dart` contient le widget `WorkoutDetailScreen`, chargé d'afficher le détail d'une séance d'entraînement.

Cet écran permet à l'utilisateur de :

- consulter les informations d'une séance ;
- visualiser la liste des exercices qui la composent ;
- modifier la séance ;
- supprimer la séance ;
- programmer la séance sur un ou plusieurs jours de la semaine.

Il constitue l'écran de consultation principal d'un `ModelWorkout`.

---

# Fonctionnement

`WorkoutDetailScreen` est un `StatefulWidget` car les informations affichées peuvent être modifiées pendant son utilisation.

Lors de son initialisation, le widget récupère une copie de la séance transmise par l'écran précédent. Cette copie est utilisée pour afficher les données et peut être remplacée après une modification afin de rafraîchir automatiquement l'interface.

---

# Structure du widget

## WorkoutDetailScreen

Widget principal représentant la page de détail d'une séance.

### Paramètres

### `workout`

```dart
final ModelWorkout workout;
```

Séance dont les informations doivent être affichées.

---

### `repository`

```dart
final WorkoutRepository repository;
```

Repository utilisé pour effectuer les opérations sur la base de données Hive.

Il permet notamment :

- de supprimer une séance ;
- de mettre à jour une séance ;
- de récupérer la version la plus récente après modification.

---

### `index`

```dart
final int index;
```

Indice de la séance dans la base Hive.

Il est utilisé lors des opérations de suppression ou de mise à jour.

---

## _WorkoutDetailScreenState

Classe responsable de la logique de l'écran.

Elle gère :

- l'affichage des informations ;
- la modification de la séance ;
- la suppression ;
- la programmation hebdomadaire.

---

# Attributs

### `workout`

```dart
late ModelWorkout workout;
```

Variable contenant la séance actuellement affichée.

Elle est initialisée dans `initState()` à partir du paramètre reçu puis est mise à jour après chaque modification.

---

# Méthodes

## initState()

Initialise la variable locale :

```dart
workout = widget.workout;
```

Cette variable est ensuite utilisée pour afficher les données de la séance.

---

## getDayName()

```dart
String getDayName(WeekDay day)
```

Convertit une valeur de l'énumération `WeekDay` en son nom en français.

Exemple :

- `WeekDay.monday` → "Lundi"
- `WeekDay.friday` → "Vendredi"

Cette méthode est utilisée pour afficher les jours dans les cases à cocher.

---

# Interface utilisateur

L'écran est composé de plusieurs parties.

## Barre supérieure

L'`AppBar` affiche :

- le nom de la séance ;
- un bouton de suppression ;
- un bouton de modification.

La barre possède une bordure rouge afin de respecter le thème graphique de l'application.

---

## Liste des exercices

Chaque exercice est affiché dans une `Card`.

Les informations affichées sont :

- nom de l'exercice ;
- nombre de séries ;
- nombre de répétitions ;
- temps de repos.

Les cartes utilisent les couleurs du thème sombre de l'application.

---

## Programme de la semaine

La seconde partie de l'écran permet de planifier la séance.

Les sept jours de la semaine sont affichés dans une carte contenant plusieurs `CheckboxListTile`.

Chaque case indique si la séance est programmée pour le jour correspondant.

---

# Modification d'une séance

Lorsque l'utilisateur appuie sur le bouton **Modifier** :

1. L'écran `CreateWorkoutScreen` est ouvert.
2. Les informations de la séance sont pré-remplies.
3. Après la fermeture de cet écran, la séance est relue depuis le `WorkoutRepository`.
4. Un `setState()` reconstruit l'interface avec les nouvelles données.

Cela garantit que les informations affichées correspondent toujours à la dernière version enregistrée.

---

# Suppression d'une séance

Le bouton de suppression appelle :

```dart
repository.deleteWorkout(index)
```

Une fois la suppression effectuée, l'écran est fermé grâce à :

```dart
Navigator.pop(context);
```

L'utilisateur revient alors à la liste des séances.

---

# Gestion de la planification

Chaque `CheckboxListTile` représente un jour de la semaine.

Lorsque l'utilisateur coche une case :

- le jour est ajouté à `workout.days` ;
- la séance est immédiatement sauvegardée dans Hive grâce à :

```dart
repository.updateWorkout(...)
```

Lorsque la case est décochée :

- le jour est supprimé de la liste ;
- la modification est enregistrée dans la base de données.

Ainsi, la planification est automatiquement sauvegardée sans action supplémentaire de l'utilisateur.

---

# Dépendances

Ce fichier utilise les éléments suivants :

- `ModelWorkout`
  - représente une séance complète.

- `WeekDay`
  - énumération représentant les jours de la semaine.

- `WorkoutRepository`
  - assure les opérations de lecture, modification et suppression dans Hive.

- `CreateWorkoutScreen`
  - utilisé pour modifier une séance existante.

- Flutter Material
  - fournit l'ensemble des composants graphiques (`Scaffold`, `Card`, `CheckboxListTile`, `AppBar`, etc.).

---

# Exemple d'utilisation

Depuis `HomeScreen` :

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => WorkoutDetailScreen(
      workout: workout,
      repository: repository,
      index: index,
    ),
  ),
);
```

L'écran reçoit la séance sélectionnée ainsi que le repository afin de pouvoir effectuer toutes les opérations nécessaires.

---

# Remarques

- L'écran recharge automatiquement la séance après une modification afin d'afficher les données les plus récentes.
- Les modifications de la planification hebdomadaire sont enregistrées immédiatement dans la base locale.
- La séparation entre l'interface (`WorkoutDetailScreen`) et la gestion des données (`WorkoutRepository`) facilite la maintenance du projet.
- L'utilisation de l'énumération `WeekDay` permet de manipuler les jours de la semaine de manière plus sûre et plus lisible qu'avec des entiers.