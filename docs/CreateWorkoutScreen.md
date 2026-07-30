# CreateWorkoutScreen

## Description

Le fichier `create_workout_screen.dart` contient le widget `CreateWorkoutScreen`, utilisé pour créer une nouvelle séance d'entraînement ou modifier une séance existante.

Cet écran permet à l'utilisateur de :

- saisir le nom d'une séance ;
- ajouter autant d'exercices que nécessaire ;
- supprimer un exercice ;
- modifier une séance existante ;
- enregistrer les informations dans la base de données locale via `WorkoutRepository`.

Selon le contexte, le widget fonctionne en mode **création** ou en mode **édition**.

---

# Fonctionnement

`CreateWorkoutScreen` est un `StatefulWidget`.

Lors de son ouverture, deux cas sont possibles :

- **Création d'une séance** : un formulaire vide est créé avec un premier exercice.
- **Modification d'une séance** : les informations de la séance sont chargées et affichées dans le formulaire afin que l'utilisateur puisse les modifier.

Une fois les informations complétées, l'utilisateur peut enregistrer la séance.

---

# Structure du widget

## CreateWorkoutScreen

Widget principal représentant l'écran de création ou de modification d'une séance.

### Paramètres

### `repository`

```dart
final WorkoutRepository repository;
```

Repository utilisé pour enregistrer ou modifier les séances dans la base de données Hive.

---

### `workout`

```dart
final ModelWorkout? workout;
```

Séance à modifier.

Si cette valeur est `null`, le widget est utilisé pour créer une nouvelle séance.

---

### `index`

```dart
final int? index;
```

Indice de la séance dans la base Hive.

Il est uniquement utilisé lors d'une modification afin de savoir quelle séance doit être remplacée.

---

## _CreateWorkoutScreenState

Classe responsable de la gestion du formulaire.

Elle s'occupe :

- du nom de la séance ;
- de la liste des exercices ;
- de la création ;
- de la modification ;
- de la sauvegarde.

---

# Attributs

## workoutNameController

```dart
final workoutNameController = TextEditingController();
```

Contrôleur associé au champ contenant le nom de la séance.

Il permet de récupérer et modifier facilement le texte saisi par l'utilisateur.

---

## exercises

```dart
final List<ModelExercise> exercises = [];
```

Liste contenant tous les exercices de la séance.

Chaque élément de cette liste est affiché grâce au widget `ExerciseForm`.

---

# Méthodes

## initState()

Initialise le formulaire.

Deux comportements sont possibles :

### Création

Si aucune séance n'est fournie :

```dart
addExerciseForm();
```

Un premier formulaire vide est automatiquement ajouté.

---

### Modification

Si une séance est fournie :

- les exercices sont copiés ;
- le nom est pré-rempli dans le champ de texte.

Les exercices sont copiés afin d'éviter de modifier directement les données avant leur sauvegarde.

---

## dispose()

```dart
workoutNameController.dispose();
```

Libère le contrôleur lorsque l'écran est fermé afin d'éviter les fuites de mémoire.

---

## addExerciseForm()

```dart
void addExerciseForm()
```

Ajoute un nouvel exercice vide dans la liste.

Après l'ajout, un `setState()` reconstruit l'interface afin d'afficher le nouveau formulaire.

---

## createWorkout()

```dart
Future<void> createWorkout()
```

Construit un objet `ModelWorkout` à partir des informations saisies.

Deux cas sont ensuite possibles.

### Création

```dart
repository.addWorkout(workout);
```

Ajoute une nouvelle séance dans Hive.

---

### Modification

```dart
repository.updateWorkout(index, workout);
```

Remplace la séance existante par la nouvelle version.

Une fois la sauvegarde terminée, l'écran est fermé grâce à :

```dart
Navigator.pop(context);
```

---

# Interface utilisateur

L'écran est composé des éléments suivants.

## Champ du nom

Un `TextField` permet de saisir le nom de la séance.

Le champ possède :

- un fond sombre ;
- une bordure rouge ;
- un texte blanc.

---

## Liste des exercices

Les exercices sont affichés grâce au widget :

```dart
ExerciseForm
```

Chaque formulaire permet de modifier :

- le nom ;
- les séries ;
- les répétitions ;
- le temps de repos.

L'utilisateur peut également supprimer un exercice.

---

## Bouton "Ajouter un exercice"

Ajoute un nouveau formulaire vide.

Cela permet de créer une séance contenant un nombre illimité d'exercices.

---

## Bouton de sauvegarde

Le texte du bouton dépend du mode de fonctionnement.

### Création

```
Créer la séance
```

---

### Modification

```
Sauvegarder la modification
```

Le bouton déclenche la méthode `createWorkout()`.

---

# Dépendances

Ce fichier utilise les éléments suivants :

- `ModelWorkout`
  - représente une séance d'entraînement.

- `ModelExercise`
  - représente un exercice.

- `WorkoutRepository`
  - gère l'enregistrement des données dans Hive.

- `ExerciseForm`
  - affiche le formulaire de chaque exercice.

- Flutter Material
  - fournit les composants graphiques de l'interface.

---

# Exemple d'utilisation

### Création

```dart
CreateWorkoutScreen(
  repository: repository,
)
```

Ouvre un formulaire vide.

---

### Modification

```dart
CreateWorkoutScreen(
  repository: repository,
  workout: workout,
  index: index,
)
```

Le formulaire est automatiquement rempli avec les informations de la séance sélectionnée.

---

# Remarques

- Le même écran est utilisé pour créer et modifier une séance, ce qui évite de dupliquer le code.
- Les exercices sont copiés avant leur modification afin de ne pas altérer la séance originale tant que l'utilisateur n'a pas enregistré ses changements.
- Le formulaire utilise un `ListView`, ce qui permet d'ajouter un grand nombre d'exercices tout en conservant un défilement fluide.
- La sauvegarde des données est entièrement déléguée au `WorkoutRepository`, ce qui sépare clairement l'interface utilisateur de la logique d'accès aux données.