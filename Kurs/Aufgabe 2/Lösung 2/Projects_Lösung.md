# Projects

## Aufgabe 2.1

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: demo-project
  namespace: argocd
spec:
  sourceRepos:
    - "https://github.com/hoffmann-f/public-argocd-training.git"
  destinations:
    - namespace: '*'
      server: '*'
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook-2
  namespace: argocd
spec:
  destination:
    namespace: guestbook-2
    server: "https://kubernetes.default.svc"
  project: demo-project
  source:
    path: guestbook
    repoURL: "https://github.com/hoffmann-f/public-argocd-training.git"
    targetRevision: HEAD
---
```

## Aufgabe 2.2

```
argocd proj create test-project -d https://kubernetes.default.svc,guestbook-allowed -s https://github.com/hoffmann-f/public-argocd-training.git --allow-cluster-resource "*/*"
```

## Aufgabe 2.3

```
argocd proj create test-project -d https://kubernetes.default.svc,guestbook-allowed -s https://github.com/hoffmann-f/public-argocd-training.git --allow-cluster-resource "*/Namespace" --allow-namespaced-resource "*/Pod" --upsert
```
Es fand kein Rollout statt, da nicht alle Ressourcen ausgerollt werden durften.

```
argocd proj create test-project -d https://kubernetes.default.svc,guestbook-allowed -s https://github.com/hoffmann-f/public-argocd-training.git --allow-cluster-resource "*/Namespace" --allow-namespaced-resource "*/Deployment" --allow-namespaced-resource "*/Service" --upsert
```

## Aufgabe 2.4

### Deklarativ

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: test-project
  namespace: argocd
spec:
  sourceRepos:
    - "https://github.com/hoffmann-f/public-argocd-training.git"
  destinations:
    - namespace: '*'
      server: '*'
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  roles:
    - name: test-role-sync
      description: ""
      policies:
        - p, proj:test-project:test-role-sync, applications, sync, test-project/*, allow
        - p, proj:test-project:test-role-sync, applications, get, test-project/*, allow
---
```

### CLI

```
argocd proj role create test-project test-role

argocd proj role add-policy test-project test-role -a create -o "*" -p allow
argocd proj role add-policy test-project test-role -a delete -o "*" -p allow
argocd proj role add-policy test-project test-role -a update -o "*" -p allow
argocd proj role add-policy test-project test-role -a get -o "*" -p allow

argocd proj role create-token test-project test-role
argocd proj role create-token test-project test-role-sync

# zuerst mit sync only token
argocd app create guestbook-2 --repo https://github.com/hoffmann-f/public-argocd-training.git --revision main --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook-proj-role --sync-option CreateNamespace=true --auth-token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJwcm9qOnRlc3QtcHJvamVjdDp0ZXN0LXJvbGUtc3luYyIsIm5iZiI6MTcwMjIzNTQ4MywiaWF0IjoxNzAyMjM1NDgzLCJqdGkiOiIyN2UxODIzOS01OGRjLTQ3ZTctYjQ4Yi1hNjFkNjk1NDNiZWYifQ.x7U9YH0A-ed61Pf_C5wmVx8hqVzHrOZFeMDbI93Wu8w

# danach mit create token
argocd app create guestbook-2 --repo https://github.com/hoffmann-f/public-argocd-training.git --revision main --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook-proj-role --sync-option CreateNamespace=true --auth-token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJwcm9qOnRlc3QtcHJvamVjdDp0ZXN0LXJvbGUiLCJuYmYiOjE3MDIyMzU0NjUsImlhdCI6MTcwMjIzNTQ2NSwianRpIjoiNzc3NDE2NTItODliNy00NjAzLWEwOTAtOTVkNmRkMzM0MThmIn0.9qys1_-KTxqpGQudrjLpcal8zBmzeXZLScL4z-WNiJw 

# danach den Sync mit create token versuchen
argocd app sync guestbook-2 --auth-token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJwcm9qOnRlc3QtcHJvamVjdDp0ZXN0LXJvbGUiLCJuYmYiOjE3MDIyMzU0NjUsImlhdCI6MTcwMjIzNTQ2NSwianRpIjoiNzc3NDE2NTItODliNy00NjAzLWEwOTAtOTVkNmRkMzM0MThmIn0.9qys1_-KTxqpGQudrjLpcal8zBmzeXZLScL4z-WNiJw

# abschließend mit Sync token
argocd app sync guestbook-2 --auth-token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJwcm9qOnRlc3QtcHJvamVjdDp0ZXN0LXJvbGUtc3luYyIsIm5iZiI6MTcwMjIzNTQ4MywiaWF0IjoxNzAyMjM1NDgzLCJqdGkiOiIyN2UxODIzOS01OGRjLTQ3ZTctYjQ4Yi1hNjFkNjk1NDNiZWYifQ.x7U9YH0A-ed61Pf_C5wmVx8hqVzHrOZFeMDbI93Wu8w
```


