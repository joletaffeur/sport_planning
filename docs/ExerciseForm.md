# ExerciseForm

## Description

Le fichier `exerciseForm.dart` contient le widget `ExerciseForm`, utilisé pour créer ou modifier un exercice dans une séance de sport.

Ce widget affiche un formulaire permettant de renseigner les différentes informations d'un exercice (nom, séries, répétitions et temps de repos). Il est utilisé par l'écran `CreateWorkoutScreen` lors de la création ou de la modification d'une séance.

Chaque formulaire est associé à une instance de `ModelExercise`. Les modifications effectuées par l'utilisateur sont directement enregistrées dans cet objet grâce aux callbacks `onChanged`.

---

# Fonctionnement

`ExerciseForm` est un `StatefulWidget`, ce qui lui permet d'être reconstruit lorsque son état change.

Le widget reçoit deux paramètres :

- `exercise` : l'exercice à modifier.
- `onDelete` : une fonction appelée lorsque l'utilisateur souhaite supprimer ce formulaire.

L'affichage est organisé dans une `Card` contenant plusieurs champs de saisie (`TextFormField`).

---

# Structure du widget

## ExerciseForm

Widget principal représentant le formulaire d'un exercice.

### Paramètres

### `exercise`

```dart
final ModelExercise exercise;
```

Objet contenant les données de l'exercice.

Toutes les modifications réalisées dans les champs du formulaire mettent directement à jour cet objet.

---

### `onDelete`

```dart
final VoidCallback onDelete;
```

Fonction exécutée lorsque l'utilisateur appuie sur le bouton de suppression.

La suppression de l'exercice est gérée par le widget parent (`CreateWorkoutScreen`).

---

## _ExerciseFormState

Classe responsable de l'affichage et de la gestion du formulaire.

Elle construit l'interface utilisateur et relie les différents champs aux propriétés du modèle.

---

# Interface utilisateur

Le formulaire est composé d'une `Card` contenant :

- un titre "Exercice" ;
- un bouton de suppression ;
- un champ pour le nom de l'exercice ;
- un champ pour le nombre de séries ;
- un champ pour le nombre de répétitions ;
- un champ pour le temps de repos.

Les couleurs et bordures sont personnalisées afin de respecter le thème général de l'application.

---

# Mise à jour des données

Chaque champ utilise la propriété `onChanged`.

Exemple :

```dart
onChanged: (value) {
  widget.exercise.name = value;
}
```

À chaque modification de l'utilisateur, la valeur est directement enregistrée dans l'objet `ModelExercise`.

Pour les valeurs numériques (`sets`, `reps`, `rest`), la conversion est réalisée avec :

```dart
int.tryParse(value) ?? 0
```

Si la saisie est invalide, la valeur enregistrée devient `0`.

---

# Suppression d'un exercice

Le bouton de suppression appelle simplement :

```dart
widget.onDelete
```

Le widget ne supprime pas lui-même l'exercice.

Il délègue cette responsabilité au widget parent, ce qui permet de séparer la logique métier de l'affichage.

---

# Dépendances

Ce fichier dépend des éléments suivants :

- `ModelExercise`
  - représente les données d'un exercice.

- `CreateWorkoutScreen`
  - crée plusieurs instances de `ExerciseForm`.

- Flutter Material
  - fournit les composants graphiques (`Card`, `TextFormField`, `IconButton`, etc.).

---

# Exemple d'utilisation

```dart
ExerciseForm(
  exercise: exercises[i],
  onDelete: () {
    setState(() {
      exercises.removeAt(i);
    });
  },
)
```

Chaque formulaire est associé à un exercice de la liste.

Lorsque le bouton de suppression est utilisé, le parent retire l'exercice de la liste puis reconstruit l'interface.

---

# Remarques

- Les données sont modifiées directement dans l'objet `ModelExercise`, ce qui évite de recopier les valeurs à chaque modification.
- Le widget est réutilisable et peut être instancié autant de fois que nécessaire pour créer une séance contenant plusieurs exercices.
- La responsabilité du widget est uniquement l'affichage et la saisie des informations ; la sauvegarde dans la base de données est assurée par `CreateWorkoutScreen` et `WorkoutRepository`.