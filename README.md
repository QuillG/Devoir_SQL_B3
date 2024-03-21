# Evaluation 2 SQL

# Table des matières

1. [Création de la base de données et alimentation](#installation)
2. [Conception](#conception)
3. [Référence](#référence)

# Installation

## 1. Cloner le projet GITHUB
Pour commencer, veuillez cloner ce git contenant le readme, schema.sql, data.sql et queries.sql :

```bash
git clone https://github.com/QuillG/Devoir_SQL_B3.git
```

## 2. Création de la DataBase
Ouvrir un terminal dans le dossier du dépôt précédemment cloner puis :

```bash
mysql -u username -p < schema.sql
```

## 3. Insertion du jeux de données

```bash
mysql -u username -p cinemasql < data.sql
```

## 4. Insertion des Queries des exercices 

```bash
mysql -u username -p cinemasql < queries.sql
```

# Conception

## Digramme MySQL WorkBench

![MCD](/MCD.png)


# Remarque

## 1. Impossible de charger le CSV
Après plusieurs essais, je n'ai pas réussi à importer le CSV, j'ai donc inséré les données à la main. L'erreur rencontrée était un problème de 'secure_file_priv'

## 2. Création des premières VIEWS
Dans la création des premières VIEWS, il m'a été impossible d'ORDER BY sur mes valeurs Matin, Apres-midi1 etc... J'arrive à les trier alphabétiquement, mais pas dans l'ordre que je veux.     














