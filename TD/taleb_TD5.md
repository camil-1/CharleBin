# TD5 – Debugger
[CAMIL][TALEB][DACS]

PS : Jai oublie de creer une nouvelle branche "debugger", mais j'aurai du le faire, donc je le mets quand meme dans le rendu
## Objectif du TD

L’objectif de ce TD est de configurer et utiliser des outils de **debugging PHP et JavaScript** pour l’application CharleBin, afin de comprendre le flux d’exécution, inspecter les variables et vérifier le comportement des fonctionnalités clés. Le TD inclut également la mise en place d’une cible `dev` dans le Makefile pour lancer l’application avec Xdebug.

---

## 1. Mise en place de la branche de travail

### Commandes exécutées
```
git checkout main
git pull origin main
git checkout -b debugger
```

### Résultat
```
On branch debugger
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```
Création d’une branche isolée pour le TD.

---

## 2. Installation de Xdebug (hors Git)

### Commandes exécutées 
```
sudo apt update
sudo apt install php-xdebug
php -v
```

### Résultat attendu
```
PHP 8.4.16 (cli) (built: ...) 
...
with Xdebug v3.4.5
```
Xdebug installé et prêt à être utilisé.

---

## 3. Ajout de la cible `dev` dans le Makefile

### Fichier modifié
```
Makefile
```

### Contenu ajouté
```makefile
dev:
	php -dxdebug.mode=debug -dxdebug.start_with_request=yes -S localhost:8080
```

### Vérification
```
make dev
```
```text
PHP 8.4.16 Development Server http://localhost:8080 started
```

### Commit
```
git add Makefile
...
```

---

## 4. Configuration du debugger PHP dans VS Code

### Fichier créé
```
.vscode/launch.json
```

### Contenu
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
    
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 0,
            "runtimeArgs": [
                "-dxdebug.start_with_request=yes"
            ],
            "env": {
                "XDEBUG_MODE": "debug,develop",
                "XDEBUG_CONFIG": "client_port=${port}"
            }
        },
        {
            "name": "Launch Built-in web server",
            "type": "php",
            "request": "launch",
            "runtimeArgs": [
                "-dxdebug.mode=debug",
                "-dxdebug.start_with_request=yes",
                "-S",
                "localhost:0"
            ],
            "program": "",
            "cwd": "${workspaceRoot}",
            "port": 9003,
            "serverReadyAction": {
                "pattern": "Development Server \\(http://localhost:([0-9]+)\\) started",
                "uriFormat": "http://localhost:%s",
                "action": "openExternally"
            }
        }
    ]
}
```

### Commit
```
git add .vscode/launch.json
...
```

---

## 5. Debug PHP

### Fichier concerné
```
lib/Controller.php
```
- Breakpoint placé dans la méthode `_create`
- Lancement du serveur : `make dev`
- Exécution du debug dans VS Code (`F5`)

### Tests réalisés
1. Création d’un paste avec expiration 1 semaine → breakpoint déclenché
2. Création d’un paste avec expiration 1 minute → comportement correct, breakpoint déclenché

Aucun fichier modifié → rien à commit.

---

## 6. Debug JavaScript

### Fichier concerné
```
js/privatebin.js
```
- Breakpoint placé sur la fonction d’envoi d’un paste
- Lancement du serveur : `make dev`
- Debug Chrome via VS Code

Travaux réalisés
1. Création d’un paste avec mot de passe → breakpoint déclenché
2. Création d’un paste sans mot de passe → fonctionnement correct, breakpoint déclenché

---

## 7. Vérification finale du dépôt

### Commande exécutée
```
git log --oneline
```
### Résultat attendu
```
<hash_commit> ...
<hash_commit> ...
```

Le dépôt contient toutes les configurations nécessaires au debug PHP et JS.

---

## Conclusion

Ce TD a permis :
- la configuration complète de Xdebug pour PHP
- la configuration du debug JS avec Chrome dans VS Code
- la mise en place d’une cible Makefile pour démarrer le serveur en mode debug
- la vérification du comportement des fonctionnalités clés de CharleBin sans modifier le code

