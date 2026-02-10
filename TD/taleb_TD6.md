[CAMIL] [TALEB]

# TD – Testing 101 : Cypress & GitHub Actions

## Objectif du TD

L’objectif de ce TD est de mettre en place des tests end-to-end (E2E) avec **Cypress** sur l’application CharleBin, puis d’automatiser leur exécution via **GitHub Actions**. Cela permet de garantir que les fonctionnalités principales de l’application fonctionnent correctement à chaque modification du code.

---

## 1. Mise en place de la branche de travail

### Commandes exécutées

```
git checkout main
git pull origin main
git checkout -b cypress
```

### Résultat

Une nouvelle branche `cypress` est créée à partir de la branche principale afin d’isoler le travail lié aux tests.

```
git status
```

```
On branch cypress
nothing to commit, working tree clean
```

---

## 2. Vérification de l’installation de Cypress

### Commande exécutée

```
npx cypress --version
```

### Résultat

```
Cypress package version: 15.9.0
Cypress binary version: 15.9.0
Electron version: 37.6.0
Bundled Node versiob: 22.19.0
```

Cela confirme que Cypress est bien installé et utilisable dans le projet.

---

## 3. Vérification et exécution des tests Cypress en local

### Fichier concerné

```
cypress/e2e/create_paste.cy.js
```

Ce fichier contient un test E2E simulant la création d’un paste, sa protection par mot de passe, puis sa lecture.

### Lancement de Cypress

```
npx cypress open
```

Le test est exécuté via l’interface graphique et passe avec succès (statut vert).

### Exécution en ligne de commande

```
npx cypress run
```

### Résultat

```
✔ All specs passed!
```

Le test fonctionne correctement en mode headless, ce qui est indispensable pour l’intégration continue.

---

## 4. État du dépôt Git après les tests

### Commande exécutée

```
git status
```

### Résultat

```
nothing to commit, working tree clean
```

L’exécution des tests n’a modifié aucun fichier, ce qui est normal puisque les tests existaient déjà.

---

## 5. Création du workflow GitHub Actions

Un workflow GitHub Actions est ajouté afin d’exécuter automatiquement les tests Cypress à chaque `push` ou `pull request`.

### Fichier créé

```
.github/workflows/cypress.yml
```

### Contenu du fichier

```
name: Cypress Tests

on:
  push:
  pull_request:

jobs:
  cypress-run:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install dependencies
        working-directory: js
        run: npm install

      - name: Start application
        run: php -S localhost:8080 &

      - name: Wait for server
        run: sleep 5

      - name: Run Cypress tests
        run: npx cypress run --project .
```

### Explication

- `working-directory: js` permet d’installer les dépendances Node.js là où se trouve le `package.json`
- `php -S localhost:8080 &` démarre l’application nécessaire aux tests
- `--project .` indique à Cypress que la configuration se trouve à la racine du dépôt

---

## 6. Commit et envoi du workflow

### Commandes exécutées

```
git add .github/workflows/cypress.yml
git commit -m "Fix Cypress CI project path"
git push origin cypress
```

### Résultat

```
git log --oneline -1
```

```
<hash_commit> Fix Cypress CI project path
```

---

## 7. Vérification dans GitHub Actions

Après l’ouverture de la Pull Request `cypress → main`, le workflow est automatiquement exécuté.

### Résultat observé

- Workflow lancé automatiquement
- Installation des dépendances réussie
- Démarrage du serveur PHP
- Exécution des tests Cypress
- ✔ Workflow terminé avec succès (vert)

---
