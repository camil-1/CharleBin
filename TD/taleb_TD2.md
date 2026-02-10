# TD2 – GitHub

> Nom :Taleb 
> Dépôt GitHub : git@github.com:camil-1/CharleBin.git
> URL de la Pull Request : https://github.com/camil-1/CharleBin/compare/remove-footer?expand=1

---

## Exercice 1 – Création du dépôt GitHub et premier push

### Rappel de la question
Créer un dépôt distant GitHub et y pousser un dépôt Git local existant.

### Commandes exécutées
```
git status
git remote add origin git@github.com:camil-1/CharleBin.git
git branch -M main
git push -u origin main
```

### Résultat (extrait)
```
On branch main
nothing to commit, working tree clean

Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### Explication
Ces commandes permettent de lier le dépôt local au dépôt distant GitHub et de publier l’historique existant sur la branche principale.

---

## Exercice 2 – Récupération d’une modification faite sur GitHub

### Rappel de la question
Récupérer localement une modification effectuée directement sur GitHub.

### Commandes exécutées
```
git status
git fetch origin
git pull origin main
git log --oneline -3
```

### Explication
La commande `git pull` permet de récupérer et fusionner les modifications distantes dans la branche locale afin de synchroniser les deux historiques.

---

## Exercice 3 – Création et gestion d’une Pull Request

### Rappel de la question
Créer une branche, effectuer des modifications, puis ouvrir une Pull Request sans la merger.

### Commandes exécutées
```
git switch -c remove-footer
# modification des fichiers page.php, bootstrap.php, fichiers i18n
git status
git diff
git add .
git commit -m "Remove footer from interface"
git push origin remove-footer
```

#git diff montre l'ancienne version d'un fichier avant modification, exemple avec le readme : 
```
camil@camil:~/Documents/IUT/q_dev/TD/TD1/PrivateBin$ git diff
diff --git a/README.md b/README.md
index 777fca5..bde1aae 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-# CharleBin
+eee# CharleBin
```

### Historique de la branche
```
# git log --oneline --decorate -3
camil@camil:~/Documents/IUT/q_dev/TD/TD1/PrivateBin$ git log --oneline --decorate
a2380db (HEAD -> remove-footer, origin/remove-footer) Remove footer
3b624be Change application name from PrivateBin to CharleBin
036fbdf Make tests work
644e4a0 Disable integrity check that doesn't work in class
47e14b1 Initial commit

```

### Explication
Une Pull Request permet de proposer des changements sans les intégrer immédiatement, afin de faciliter la revue du code et la discussion.

---

## Exercice 4 – Structuration du dépôt GitHub

### Rappel de la question
Améliorer la structure du dépôt en ajoutant de la documentation et des règles de contribution.

---

### 4.1 Ajout du README

#### Commandes exécutées
```
git switch main
git add README.md
git commit -m "Add README documentation"
git push origin main
```

#### Résultat (extrait)
```
[main] Add README documentation
```

#### Explication
Le fichier README décrit le projet, son utilisation et facilite la compréhension du dépôt pour les utilisateurs et contributeurs.

---

### 4.2 Ajout des règles de contribution

#### Commandes exécutées
```
git add .github/CONTRIBUTING.md
git commit -m "Add contributing guidelines"
git push origin main
```

#### Résultat (extrait)
```
[main] Add contributing guidelines
```

#### Explication
Les règles de contribution définissent un workflow clair afin d’harmoniser les contributions au projet.

---

### 4.3 Ajout d’un template de Pull Request

#### Commandes exécutées
```
git add .github/pull_request_template.md
git commit -m "Add pull request template"
git push origin main
```

#### Résultat (extrait)
```text
[main] Add pull request template
```

#### Explication
Un template de Pull Request aide les contributeurs à fournir des informations claires et structurées lors de la soumission de modifications.

