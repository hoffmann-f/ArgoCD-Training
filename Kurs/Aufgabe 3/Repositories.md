# Repositories

Während öffentliche Repositories direkt von ArgoCD verwendet werden können, benötigen private Repositories Credentials.
Diese werden ArgoCD als Kubernetes Secret zur Verfügung gestellt.

Siehe https://argo-cd.readthedocs.io/en/stable/user-guide/private-repositories/#private-repositories für zusätzliche
Informationen.

Der deklarative Ansatz ist hier zu finden:
https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#repository-credentials


## Credentials

Credentials können per deklarativ, per CLI oder per UI angelegt werden.

### Deklarativ

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-repo
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: "git"
  url: "https://github.com/hoffmann-f/private-argo-repo"
  project: "default"
  password: "my-password"
  username: "my-username"
```

Das Label ist hier essenziell.
