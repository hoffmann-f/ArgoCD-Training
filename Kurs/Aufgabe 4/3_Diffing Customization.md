# Diffing Customization

Es ist möglich, dass Ressourcen durch verschiedene Komponenten angepasst werden, nachdem sie an Kubernetes gesendet wurden. 
<br>
Sei es durch z.B. einen "Admission Controller" oder auch durch einen Pod Autoscaler.
Weitere Möglichkeiten sind Helm Template Funktionen, die bei jedem Durchlauf andere Ausgaben erzeugen (z.B. randAlphaNum)
oder falls ein Manifest Kubernetes unbekannte Felder enthält, die nicht mit erstellt werden.

Diese Veränderung steht im Gegensatz zu der in Git definierten Ressource.
<br>
Um durch diese Änderungen keinen "Out of Sync" Status zu erreichen.

Diffing Customization kann auf Applikations- oder Systemebene eingestellt werden.

> Weitere Informationen: https://argo-cd.readthedocs.io/en/stable/user-guide/diffing/

## Ignoring Options

- JSON patches / JSON Pointers (RFC6902) 
- JQ path expressions
- Ignorieren von Feldern, welche von bestimmten Managern gesteuert werden und in metadata.managedFields definiert sind.

### JSON Pointers
```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  ...
ignoreDifferences:
  - group: apps
    kind: Deployment
    jsonPointers:
      - /spec/replicas
---
```

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  ...
ignoreDifferences:
  - group: apps
    kind: Deployment
    name: guestbook
    jsonPointers:
      - /spec/replicas
---
```

### jq expressions

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  ...
ignoreDifferences:
  - group: apps
    kind: Deployment
    jqPathExpressions:
      - .spec.template.spec.initContainers[] | select(.name == "injected-init-container")
---
```

### Managers

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  ...
ignoreDifferences:
  - group: *
    kind: *
    managedFieldsManagers:
      - kube-controller-manager
---
```


