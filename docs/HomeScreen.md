# HomeScreen

## Description

Le fichier `home_screen.dart` contient le widget `HomeScreen`, qui représente l'écran d'accueil de l'application.

Cet écran constitue le point d'entrée principal de l'utilisateur. Il permet de consulter toutes les séances enregistrées, d'accéder à la création d'une nouvelle séance ainsi qu'à la page affichant les entraînements prévus pour la journée.

L'écran met également en place l'identité visuelle de l'application grâce à un fond personnalisé, un thème sombre et des couleurs rouges utilisées comme couleur d'accentuation.

---

# Fonctionnement

`HomeScreen` est un `StatefulWidget`.

À chaque construction de l'écran :

1. les séances sont récupérées depuis le `WorkoutRepository` ;
2. elles sont affichées sous forme d'une liste de cartes ;
3. l'utilisateur peut sélectionner une séance pour consulter son détail ;
4. lorsqu'une nouvelle séance est créée ou qu'une séance existante est modifiée, l'écran est automatiquement reconstruit afin d'afficher les données mises à jour.

---

# Structure du widget

## HomeScreen

Widget principal représentant la page d'accueil de l'application.

### Paramètres

### `repository`

```dart
final WorkoutRepository repository;
```

Repository chargé d'accéder aux données enregistrées dans Hive.

Toutes les opérations de lecture des séances passent par ce composant.

---

## _HomeScreenState

Classe responsable de l'affichage et de la gestion des interactions de l'écran.

Elle gère notamment :

- l'affichage des séances ;
- la navigation entre les différents écrans ;
- le rafraîchissement de la liste après une modification.

---

# Interface utilisateur

L'écran est composé de plusieurs éléments.

## AppBar

La barre supérieure affiche :

- le titre **"Mes séances"** ;
- un thème sombre ;
- une bordure rouge située sous la barre.

Cette barre permet d'identifier immédiatement la page principale de l'application.

---

## Boutons d'action

Deux boutons flottants sont affichés au bas de l'écran.

### Ajouter une séance

Le premier bouton ouvre l'écran `CreateWorkoutScreen`.

Il permet de créer une nouvelle séance d'entraînement.

Après la fermeture de cet écran, un `setState()` est exécuté afin de recharger automatiquement la liste des séances.

---

### Séances du jour

Le second bouton ouvre l'écran `TodayWorkoutScreen`.

Cet écran affiche uniquement les séances programmées pour la journée en cours.

---

## Image de fond

L'écran utilise un `Stack` afin de superposer plusieurs éléments.

Le fond est constitué :

- d'une image (`home_background.jpg`) ;
- d'un voile noir semi-transparent.

Cette superposition améliore la lisibilité du texte tout en conservant un arrière-plan personnalisé.

---

## Liste des séances

Les séances sont affichées dans un `ListView.builder`.

Chaque séance est représentée par une `Card` contenant :

- le nom de la séance ;
- le nombre d'exercices ;
- un style graphique correspondant au thème de l'application.

Lorsque l'utilisateur sélectionne une carte, l'écran de détail de la séance est ouvert.

---

# Chargement des données

Les séances sont récupérées grâce à un `FutureBuilder`.

Le chargement est effectué via :

```dart
widget.repository.getWorkouts()
```

Pendant le chargement, un indicateur de progression (`CircularProgressIndicator`) est affiché.

Une fois les données disponibles, la liste est générée automatiquement.

---

# Navigation

L'écran permet d'accéder aux principales fonctionnalités de l'application.

## Création d'une séance

```dart
CreateWorkoutScreen
```

Permet d'ajouter une nouvelle séance.

---

## Consultation d'une séance

```dart
WorkoutDetailScreen
```

Permet de consulter le détail d'une séance, de la modifier ou de la supprimer.

---

## Séances du jour

```dart
TodayWorkoutScreen
```

Affiche uniquement les séances programmées pour le jour courant.

---

# Dépendances

Ce fichier utilise les éléments suivants :

- `ModelWorkout`
  - représente une séance d'entraînement.

- `WorkoutRepository`
  - fournit l'accès aux données stockées dans Hive.

- `CreateWorkoutScreen`
  - utilisé pour créer une nouvelle séance.

- `WorkoutDetailScreen`
  - utilisé pour consulter et modifier une séance.

- `TodayWorkoutScreen`
  - affiche les entraînements prévus pour la journée.

- Flutter Material
  - fournit l'ensemble des composants graphiques.

---

# Exemple d'utilisation

Après le démarrage de l'application, `HomeScreen` est utilisé comme écran principal :

```dart
HomeScreen(
  repository: repository,
)
```

Toutes les interactions de l'utilisateur commencent depuis cette page.

---

# Remarques

- La liste des séances est automatiquement actualisée après la création ou la modification d'une séance grâce à `setState()`.
- L'utilisation d'un `Stack` permet de combiner une image de fond et un voile sombre sans masquer le contenu de l'écran.
- Les données affichées proviennent exclusivement du `WorkoutRepository`, ce qui sépare clairement l'interface utilisateur de la gestion des données.
- Cet écran constitue le point central de navigation de l'application et donne accès à l'ensemble des fonctionnalités principales.