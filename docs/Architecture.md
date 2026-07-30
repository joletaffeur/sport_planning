# Architecture du projet

## Description générale

Le projet est une application mobile de gestion de séances de sport développée avec Flutter.

L'application permet à l'utilisateur de créer des séances d'entraînement, d'ajouter des exercices, de programmer les séances sur différents jours de la semaine et de consulter les entraînements prévus pour aujourd'hui.

L'architecture du projet est organisée autour de plusieurs couches :

- les modèles de données ;
- les écrans (interfaces utilisateur) ;
- les widgets réutilisables ;
- la gestion des données locales.

---

# Organisation des dossiers

L'arborescence principale du projet est organisée comme ceci :

```
lib/
│
├── models/
│   ├── model_workout.dart
│   ├── model_exercise.dart
│   └── week_day.dart
│
├── repositories/
│   └── workout_repository.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── create_workout_screen.dart
│   ├── workout_detail_screen.dart
│   └── today_workout_screen.dart
│
├── widgets/
│   └── exerciseForm.dart
│
└── main.dart
```

---

# Couche Models

Le dossier `models` contient les classes représentant les données manipulées par l'application.

## ModelWorkout

Représente une séance d'entraînement complète.

Elle contient :

- un nom ;
- une liste d'exercices ;
- une liste de jours programmés.

Relations :

```
ModelWorkout
      |
      |
      └── List<ModelExercise>
```

---

## ModelExercise

Représente un exercice individuel.

Il contient :

- le nom de l'exercice ;
- le nombre de séries ;
- le nombre de répétitions ;
- le temps de repos.

Un `ModelExercise` appartient toujours à une séance `ModelWorkout`.

---

## WeekDay

Enumération représentant les jours de la semaine.

Elle permet de programmer une séance sur un ou plusieurs jours.

Exemple :

```
Workout
   |
   ├── Lundi
   ├── Mercredi
   └── Vendredi
```

---

# Couche Repository

Le dossier `repositories` contient la logique d'accès aux données.

## WorkoutRepository

Cette classe sert d'intermédiaire entre l'application et la base de données Hive.

Elle permet :

- d'ajouter une séance ;
- de récupérer toutes les séances ;
- de récupérer une séance précise ;
- de modifier une séance ;
- de supprimer une séance.

Architecture :

```
Screen
  |
  |
  v
WorkoutRepository
  |
  |
  v
Hive Database
```

Les écrans ne communiquent donc jamais directement avec Hive.

---

# Couche Screens

Le dossier `screens` contient les différentes pages de l'application.

## HomeScreen

Écran principal de l'application.

Fonctionnalités :

- afficher toutes les séances enregistrées ;
- accéder aux détails d'une séance ;
- créer une nouvelle séance ;
- accéder aux séances prévues aujourd'hui.

---

## CreateWorkoutScreen

Permet de créer ou modifier une séance.

Fonctionnalités :

- saisir le nom d'une séance ;
- ajouter des exercices ;
- modifier les exercices existants ;
- enregistrer les changements.

Flux :

```
Utilisateur
    |
    v
CreateWorkoutScreen
    |
    v
WorkoutRepository
    |
    v
Hive
```

---

## WorkoutDetailScreen

Affiche le détail d'une séance.

Fonctionnalités :

- afficher les exercices ;
- supprimer une séance ;
- modifier une séance ;
- programmer les jours d'entraînement.

---

## TodayWorkoutScreen

Affiche les séances prévues pour le jour actuel.

Fonctionnement :

1. récupération du jour actuel ;
2. comparaison avec les jours programmés des séances ;
3. affichage des séances correspondantes.

Exemple :

```
Jour actuel : Lundi

Workout A
days :
[Monday, Friday]

=> Affiché
```

---

# Couche Widgets

Le dossier `widgets` contient des composants réutilisables.

## ExerciseForm

Widget permettant d'afficher le formulaire d'un exercice.

Il gère :

- le nom ;
- les séries ;
- les répétitions ;
- le repos ;
- la suppression d'un exercice.

Il est utilisé dans :

```
CreateWorkoutScreen
        |
        |
        └── ExerciseForm
```

---

# Base de données

Le projet utilise Hive comme solution de stockage locale.

Hive permet :

- une sauvegarde rapide des données ;
- un fonctionnement hors ligne ;
- une sérialisation automatique des modèles.

Les classes sauvegardées sont :

```
Hive
 |
 ├── ModelWorkout
 |
 ├── ModelExercise
 |
 └── WeekDay
```

---

# Flux général de l'application

## Création d'une séance

```
Utilisateur
    |
    v
CreateWorkoutScreen
    |
    v
ModelWorkout
    |
    v
WorkoutRepository
    |
    v
Hive
```

---

## Consultation d'une séance

```
Hive
 |
 v
WorkoutRepository
 |
 v
HomeScreen
 |
 v
WorkoutDetailScreen
```

---

## Affichage des séances du jour

```
Date actuelle
      |
      v
TodayWorkoutScreen
      |
      v
Comparaison avec WeekDay
      |
      v
Affichage des séances
```

---

# Technologies utilisées

## Flutter

Framework utilisé pour développer l'application mobile.

## Dart

Langage de programmation utilisé par Flutter.

## Hive

Base de données locale utilisée pour sauvegarder les séances et exercices.

## Android SDK

Environnement nécessaire pour compiler et exécuter l'application sur Android.

---

# Principes d'architecture appliqués

Le projet suit une séparation des responsabilités :

- les modèles gèrent les données ;
- les écrans gèrent l'affichage et les interactions utilisateur ;
- les widgets permettent de réutiliser des composants ;
- le repository centralise l'accès aux données.

Cette organisation permet de faciliter la maintenance, l'évolution et la compréhension du projet.