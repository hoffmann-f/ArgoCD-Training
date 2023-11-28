# Application

## Aufgabe 1.1
Minimale Konfiguration
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
    name: guestbook
    namespace: argocd
spec:
    destination:
        namespace: guestbook
        server: "https://kubernetes.default.svc"
    project: default
    source:
        path: guestbook
        repoURL: "https://github.com/hoffmann-f/guestbook-example.git"
        targetRevision: HEAD
```