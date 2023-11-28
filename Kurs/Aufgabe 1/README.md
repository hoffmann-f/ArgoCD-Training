# Application

Custom Resource Definition von ArgoCD Application:

https://argo-cd.readthedocs.io/en/stable/user-guide/application-specification/#application-specification

## Aufgabe 1.1

### Minimale Konfiguration
Schreibe eine minimale Konfiguration um mit ArgoCD die Testapplikation unter:
https://github.com/hoffmann-f/guestbook-example.git"
auszurollen.

Für die minimale Konfiguration werden folgende Angaben benötigt.
- destination
- source

Hilfe:
>! 
> - apiVersion
> - kind
> - metadata
>   - name
>   - namespace
> - spec
>   - destination
>     - namespace
>     - server
>   - source
>     - path
>     - repoURL
>     - targetRevision
>   - project

## Aufgabe 1.2
