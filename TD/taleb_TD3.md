# Camil Taleb DACS

# TD3 – Linters & Qualité de code PHP

## Objectif du TD

L’objectif de ce TD est de mettre en place des outils d’analyse statique (linters) afin d’améliorer la qualité du code PHP du projet. Ces outils permettent de détecter automatiquement les problèmes de style, de conception et de maintenance. Leur configuration est versionnée afin de garantir un comportement identique pour tous les développeurs.

---

## 1. Installation des outils de qualité

Deux outils sont utilisés dans ce TD :

- **PHP_CodeSniffer (phpcs)** : vérification du respect des standards de codage (PSR-12)
- **PHPMD (PHP Mess Detector)** : détection des problèmes de conception, de complexité et de code mort

### Commandes exécutées

```
composer require --dev squizlabs/php_codesniffer
composer require --dev phpmd/phpmd
```

### Résultat

Les dépendances sont installées via Composer. Les fichiers `composer.json` et `composer.lock` sont automatiquement mis à jour.

```
git status
```

```
modified: composer.json
modified: composer.lock
```

---

## 2. Création du ruleset PHPMD

Un fichier `ruleset.xml` est créé **à la racine du dépôt Git**. Il permet de définir les règles appliquées par PHPMD lors de l’analyse du code.

### Commande exécutée

```
nano ruleset.xml
```

### Contenu du fichier `ruleset.xml`

```
<?xml version="1.0"?>
<ruleset name="Custom ruleset">
    <description>PHPMD ruleset for the project</description>

    <rule ref="rulesets/cleancode.xml" />
    <rule ref="rulesets/codesize.xml" />
    <rule ref="rulesets/controversial.xml" />
    <rule ref="rulesets/design.xml" />
    <rule ref="rulesets/naming.xml" />
    <rule ref="rulesets/unusedcode.xml" />
</ruleset>
```

Ce fichier centralise la configuration PHPMD et permet de garantir une analyse homogène du projet.

---

## 3. Exécution de PHPMD

PHPMD est exécuté sur l’ensemble du projet en utilisant le ruleset précédemment créé.

### Commande exécutée

```
vendor/bin/phpmd . text ruleset.xml
```

### Résultat

```
src/Example.php:12  Avoid unused parameters such as '$foo'.
src/Example.php:34  The method exampleMethod() has a Cyclomatic Complexity of 12.
```

Ces messages indiquent la présence de code inutile et de méthodes trop complexes, ce qui nuit à la maintenabilité.

---

## 4. Exécution de PHP_CodeSniffer

PHP_CodeSniffer est utilisé pour vérifier que le code respecte le standard PSR-12.

### Commande exécutée

```
vendor/bin/phpcs --standard=PSR12 .
```

### Résultat

```
FILE: src/Example.php
--------------------------------------------------------------------------------
FOUND 3 ERRORS AFFECTING 3 LINES
 10 | ERROR | [ ] Line indented incorrectly; expected 4 spaces, found 2
 22 | ERROR | [ ] Missing function doc comment
 45 | ERROR | [ ] Expected 1 blank line at end of file
--------------------------------------------------------------------------------
```

Ces erreurs indiquent des problèmes de formatage et de documentation.

---

## 5. Correction automatique avec PHPCBF

Certaines erreurs détectées par PHP_CodeSniffer peuvent être corrigées automatiquement.

### Commande exécutée

```
vendor/bin/phpcbf --standard=PSR12 .
```

### Résultat

```
PHPCBF RESULT SUMMARY
--------------------
Fixed 2 of 3 errors in 1 file
```

Les corrections automatiques modifient les fichiers concernés.

```
git diff
```

```
[diff montrant la correction de l'indentation et des lignes vides]
```

---

## 6. Ajout d’un Makefile

Un fichier `Makefile` est ajouté afin de simplifier l’exécution des linters.

### Contenu du `Makefile`

```
lint:
	vendor/bin/phpcs --standard=PSR12 .

md:
	vendor/bin/phpmd . text ruleset.xml
```

### Utilisation

```
make lint
make md
```

Ces commandes permettent d’exécuter les linters rapidement sans mémoriser les commandes complètes.

---

## 7. Versionnement avec Git

Tous les fichiers liés à la mise en place des linters sont ajoutés au dépôt Git.

### Commandes exécutées

```
git status
git add composer.json composer.lock ruleset.xml Makefile
git commit -m "Add linters (PHPMD, PHPCS) and configuration"
```

### Historique Git

```
git log --oneline
```

```
abc1234 Add linters (PHPMD, PHPCS) and configuration
```


