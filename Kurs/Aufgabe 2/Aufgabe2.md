# Projects Aufgaben
## Aufgabe 2.1


Schreibe ein YAML File, welches ein Projekt erstellt beschränke dabei das Source Repo auf
"https://github.com/hoffmann-f/public-argocd-training.git"

Versuche nun eine Applikation von "https://github.com/argoproj/argocd-example-apps.git" zu installieren. (Aufgabe 1)
Nur ändere das Projekt auf das hier erstellte.

## Aufgabe 2.2

Erstelle ein Projekt, welches als Ziel den Namespace "guestbook-allowed" erlaubt.
Das Repo ist wieder: https://github.com/hoffmann-f/public-argocd-training.git

Verwende hierzu die CLI.

> Um Group und Kind zu definieren, trenne die Werte mit '/'

Versuche nun die Applikation in einen anderen Namespace zu deployen.

Passe die Applikation und ggf. den CLI Befehl an, sodass sie ausgerollt wird.

## Aufgabe 2.3

Passe das Projekt an, sodass nur Pods und Namespaces erstellt werden dürfen.

Versuche die Applikation über dieses Projekt auszurollen.

Was passiert?

Passe die Berechtigungen so an, dass es ausgerollt werden darf. Verwende dazu nur die benötigten Ressourcen.

# Aufgabe 2.4

Erstelle das Projekt: "test-project" mit einer Rolle "test-role-sync", die die Actions: "get" und "sync" erlaubt.

Erstelle eine weitere Rolle "test-role" per CLI im "test-project", die die Actions: "get", "create", "delete" und "update" enthält.

Erstelle nun die Applikation "guestbook" zuerst mit der Rolle "test-role-sync" per CLI.

Verwende danach die Rolle "test-role".

Synchronisiere nun die Applikation mit einer geeigneten Rolle.

