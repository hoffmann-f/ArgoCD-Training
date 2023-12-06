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
        repoURL: "https://github.com/argoproj/argocd-example-apps.git"
        targetRevision: HEAD
```

## Aufgabe 1.2
```
argocd app create guestbook-2 --repo https://github.com/argoproj/argocd-example-apps.git --revision master --path gu
estbook --dest-server https://kubernetes.default.svc --dest-namespace app-2 --syncoption CreateNamespace=true

argocd app sync guestbook-2

argocd app list
```