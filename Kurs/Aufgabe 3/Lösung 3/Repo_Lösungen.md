# Repositories

## Aufgabe 3.1

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: repo-private-argo-training
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: "git"
  project: "default"
  url: "https://github.com/hoffmann-f/private-argocd-training.git"
  password: "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"
  username: "none"
```

Create yaml "application-3-1.yaml" with application:
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

Apply YAML
```
kubectl apply -f application-3-1.yaml 
```


## Aufgabe 3.2

```
argocd repo add https://github.com/hoffmann-f/private-argocd-training --username fake --password github_pat_11BEEXQCA08XmP2qCRuC57_kc1
Q7ftvz95R6SnH9o2rVY7TDEQIj8Ldh2hZRf03llGMPXQKPRC7PDmT7bB
```

```
argocd app create guestbook-3 --repo https://github.com/hoffmann-f/private-argocd-training.git --revision main --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace app-3 --sync-option CreateNamespace=true
argocd app sync guestbook-3
```
