# Repository Aufgaben

## Repo Data
URL: https://github.com/hoffmann-f/private-argocd-training.git<br>
Token: ``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``

```yaml
---
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
    repoURL: "https://github.com/hoffmann-f/private-argocd-training.git"
    targetRevision: HEAD
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
---
```

## Aufgabe 3.1

Verbinde das Repo ``https://github.com/hoffmann-f/private-argocd-training`` mittels Secret und Rolle die Applikation aus.

## Aufgabe 3.2

Login für die CLI:
```
argocd login localhost:8080 --insecure
```

Lösche das Repository über k9s. (Lösche das Secret)

Verbinde das Repo ``https://github.com/hoffmann-f/private-argocd-training`` via CLI und Rolle die Applikation aus.