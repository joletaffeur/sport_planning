# main.dart

## Description

Le fichier `main.dart` est le point d'entrée principal de l'application Flutter.

Il est exécuté au lancement de l'application et s'occupe de :

- l'initialisation de Flutter ;
- l'initialisation de la base de données locale Hive ;
- l'enregistrement des adaptateurs Hive ;
- l'ouverture de la base de données ;
- la création du repository ;
- le lancement de l'interface principale de l'application.

C'est le premier fichier exécuté lorsque l'utilisateur démarre l'application.

---

# Fonctionnement général

Le démarrage de l'application suit cette logique :

```
Lancement application
        |
        v
Initialisation Flutter
        |
        v
Initialisation Hive
        |
        v
Enregistrement des modèles
        |
        v
Ouverture de la base locale
        |
        v
Création du Repository
        |
        v
Affichage de HomeScreen
```

---

# Fonction main()

```dart
void main() async
```

La fonction `main()` est la fonction appelée automatiquement par Flutter au démarrage.

Elle est déclarée en `async` car plusieurs opérations nécessitent une attente :

- initialisation de Hive ;
- ouverture de la base de données.

---

# Initialisation Flutter

```dart
WidgetsFlutterBinding.ensureInitialized();
```

Cette ligne garantit que Flutter est correctement initialisé avant d'effectuer des opérations nécessitant l'accès aux fonctionnalités natives.

Elle est nécessaire ici car Hive est initialisé avant le lancement de l'application.

---

# Initialisation de Hive

```dart
await Hive.initFlutter();
```

Cette instruction initialise Hive pour une utilisation avec Flutter.

Hive est utilisé comme base de données locale afin de sauvegarder :

- les séances (`ModelWorkout`) ;
- les exercices (`ModelExercise`) ;
- les jours de la semaine (`WeekDay`).

---

# Enregistrement des adaptateurs Hive

```dart
Hive.registerAdapter(WeekDayAdapter());
Hive.registerAdapter(ModelWorkoutAdapter());
Hive.registerAdapter(ModelExerciseAdapter());
```

Hive ne sait pas sauvegarder directement les objets Dart personnalisés.

Les adaptateurs permettent de convertir les objets en données stockables puis de les reconstruire lors de la lecture.

Les modèles enregistrés sont :

| Classe | Rôle |
|---|---|
| `ModelWorkoutAdapter` | Sauvegarde les séances |
| `ModelExerciseAdapter` | Sauvegarde les exercices |
| `WeekDayAdapter` | Sauvegarde les jours de la semaine |

---

# Ouverture de la base de données

```dart
final box = await Hive.openBox<ModelWorkout>("workouts");
```

Cette ligne ouvre une boîte Hive appelée :

```
workouts
```

Cette boîte contient tous les objets `ModelWorkout`.

Elle représente le stockage principal de l'application.

Structure :

```
Hive
 |
 └── workouts
        |
        ├── Workout 1
        |
        ├── Workout 2
        |
        └── Workout 3
```

---

# Création du Repository

```dart
final repository = WorkoutRepository(box);
```

Le repository sert d'intermédiaire entre l'application et Hive.

Les écrans utilisent le repository pour :

- créer une séance ;
- récupérer les séances ;
- modifier une séance ;
- supprimer une séance.

Cela évite que les écrans manipulent directement la base de données.

Architecture :

```
Screen
  |
  v
WorkoutRepository
  |
  v
Hive
```

---

# Lancement de l'application

```dart
runApp(
  MainApp(
    repository: repository,
  )
);
```

Cette instruction démarre l'application Flutter.

Le repository est transmis à `MainApp`, puis envoyé aux différents écrans.

---

# Classe MainApp

```dart
class MainApp extends StatelessWidget
```

Cette classe représente la racine de l'application.

Elle configure le `MaterialApp` et définit l'écran affiché au lancement.

---

## MaterialApp

```dart
return MaterialApp(
  home: HomeScreen(
    repository: repository
  ),
);
```

L'écran principal de l'application est :

```
HomeScreen
```

Le repository lui est transmis afin qu'il puisse accéder aux séances enregistrées.

---

# Dépendances

Le fichier utilise :

## Flutter

```dart
import 'package:flutter/material.dart';
```

Utilisé pour créer l'interface et lancer l'application.

---

## Hive

```dart
import 'package:hive_flutter/hive_flutter.dart';
```

Utilisé pour gérer la base de données locale.

---

## Models

```dart
ModelWorkout
ModelExercise
WeekDay
```

Ces classes représentent les données enregistrées.

---

## Repository

```dart
WorkoutRepository
```

Permet la communication entre les écrans et Hive.

---

## Screens

```dart
HomeScreen
```

Premier écran affiché après le démarrage.

---

# Rôle dans l'architecture

Le fichier `main.dart` est le point central qui connecte toutes les parties du projet.

Il relie :

```
Models
   |
   v
Hive
   |
   v
WorkoutRepository
   |
   v
Screens
```

Il ne contient pas de logique métier mais uniquement la configuration et l'initialisation de l'application.