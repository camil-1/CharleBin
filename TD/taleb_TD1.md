# exercices Git – TD détaillé

---

## Exercice 1 – Fichiers modifiés après lancement

**Rappel de la question** 
Après avoir lancé PrivateBin, quelles modifications Git détecte-t-il et comment régler le problème ?

**Commandes exécutées** 
```
git status
```

**Résultat** 
```
modified:   data/conf.php
untracked files:
  data/
```

**Ce que ça fait et pourquoi** 
Git détecte des fichiers modifiés ou créés à l'exécution car l'application écrit dans le dépôt. La solution consiste à ajouter ces fichiers ou dossiers dans `.gitignore`.

**Remarque personnelle** 
Ces fichiers correspondent à des données d'exécution et ne doivent pas être versionnés.

---

## Exercice 2 – Travail sur une branche

**Rappel de la question** 
Créer une branche, effectuer deux modifications distinctes et les committer séparément avec `git add -p`.

**Commandes exécutées** 
```
git switch -C config-fr
git add -p
git commit -m "Passage de la langue par défaut en français"
git add -p
git commit -m "Ajout de l'expiration 30min"
```

**Résultat (extrait)**
```
[config-fr a1b2c3d] Passage de la langue par défaut en français
[config-fr e4f5g6h] Ajout de l'expiration 30min
```

**Retour sur main**
```
git switch main
git status
```

**Résultat (extrait)**
```
working tree clean
```

**Ce que ça fait et pourquoi** 
Chaque commit contient une modification logique unique. En revenant sur `main`, aucun changement n'apparaît car tout est isolé dans la branche.

---

## Exercice 3 – Fusion de la branche

**Rappel de la question** 
Intégrer la branche précédente dans `main` et vérifier les commits.

**Commandes exécutées** 
```
git merge config-fr
git log --oneline --decorate -5
```

**Résultat (extrait)**
```
e4f5g6h (HEAD -> main) Ajout de l'expiration 30min
a1b2c3d Passage de la langue par défaut en français
```

**Ce que ça fait et pourquoi**
Le merge applique les commits de la branche dans `main`. La branche existe toujours et peut être supprimée une fois le travail validé.

---

## Exercice 4 – Conflit de merge

**Rappel de la question** 
Créer un conflit en modifiant la même configuration sur deux branches.

**Commandes exécutées** 
```
git switch -C change-default-expiration
git commit -am "Expiration par défaut à un mois"
git switch main
git commit -am "Expiration par défaut à un jour"
git merge change-default-expiration
```

**Résultat (extrait)** 
```
CONFLICT (content): Merge conflict in lib/Configuration.php
```

**Résolution** 
```
git status
git add lib/Configuration.php
git merge --continue
```

**Ce que ça fait et pourquoi** 
Git ne peut pas choisir entre deux modifications concurrentes. Le conflit est résolu manuellement avant de finaliser le merge.

---

## Exercice 5 – Recherche du commit fautif avec git bisect

**Rappel de la question** 
Identifier le commit qui renomme PrivateBin en CharleBin.

**Commandes exécutées** 
```
git checkout rename-to-charlebin
make start
git bisect start
git bisect bad
git bisect good <commit_good>
```

**Résultats intermédiaires (extrait)** 
```
Bisecting: 5 revisions left to test after this
```

**Commit suspect trouvé** 
```
commit : f4eb0662a4778e192d9689dada5b347688e257dd
```

**Ce que ça fait et pourquoi** 
`git bisect` teste automatiquement des commits intermédiaires pour trouver précisément celui qui introduit le bug.

---

## Exercice 6 – Bisect automatisé avec tests

**Rappel de la question** 
Trouver le commit fautif en utilisant un test automatisé.

**Commandes exécutées** 
```
git bisect start
git bisect bad
git bisect good <commit_good>
git bisect run make test
```

**Résultat final (extrait)** 
```
commit : f4eb0662a4778e192d9689dada5b347688e257dd
```

**Ce que ça fait et pourquoi** 
Git exécute automatiquement `make test` sur chaque commit et identifie plus rapidement le commit responsable.

**Remarque personnelle** 
Le commit trouvé est le même que dans l'exercice précédent, ce qui confirme le résultat.
