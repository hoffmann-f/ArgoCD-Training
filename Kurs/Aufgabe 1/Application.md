# ArgoCD Application Tools
In der Applikationsdefinition kann das Tool mit angegeben werden.

```yaml
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

### Ohne Definition
```yaml
---
...
  source:
    
---
```

## Helm Charts

```yaml
---
...
  source:
---
```

## Kustomize

```yaml
---
...
  source:
---
```

## Directory of YAML


```yaml
---
...
  source:
    directory:
      recurse: true
---
```
## Jsonnet

```yaml
---
...
  source:
    
---
```