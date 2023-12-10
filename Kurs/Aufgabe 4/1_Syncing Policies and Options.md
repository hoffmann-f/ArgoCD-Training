# Sync Policies and Options

## Automated Synchronizing

- Alle 3 Minuten synchronisiert ArgoCD die Repositories und stellt somit Änderungen fest
- ArgoCD kann konfiguriert werden automatisch Änderungen im git in das Cluster zu synchronisieren. Sobald Änderungen am Code registriert werden
  - Vorteile:
    - Keine manuellen Synchronisierungen
    - CI/CD Pipelines benötigen keinen direkten Zugriff mehr auf das Cluster
  - Nachteile:
    - Wird nur durchgeführt, wenn die Applikation "OutOfSync" ist.
    - Falls ein automatischer Synchronisierungsvorgang fehlgeschlagen ist, wird kein neuer Versuch mit dem selben Commit unternommen
    - Rollback ist bei einer Applikation mit auto sync nicht verfügbar

Auto Sync kann über die Applikations-YAML eingeschaltet werden, über die CLI oder die UI.


### Automated Pruning

Automated Pruning sorgt dafür, dass wenn Ressourcen in Git gelöscht werden, diese auch in Kubernetes gelöscht werden.
<br>
>Dieses Verhalten ist standardmäßig deaktiviert

### Automated Self Healing

Wenn aktiviert stellt "Automated Self Healing" stets den Zustand des Git Repositories wieder her. 
<br>
Das bedeutet: Per Hand Änderungen am Cluster werden wieder zurückgeändert.

> Dieses Feature ist standardmäßig deaktivert

### Sync Options

Sync Options dienen dazu verschiedene Optionen auf Ressourcen oder Applikationsebene für das Synchronisieren zu aktivieren.
<br>
Dabei werden die Optionen auf Ressourcenebene als annotation gesetzt

Beispiel:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    argocd.argoproj.io/sync-options: <option>
```

#### No Prune

Wird auf Ressourcenebene angegeben. Es verhindert, dass das Objekt abgerissen wird. Siehe "Auto Pruning"

    argocd.argoproj.io/sync-options: Prune=false

#### No Validation

Wird auf Applikations- oder Ressourcenebene angegeben. Es sorgt dafür, dass Ressourcen nicht validiert werden. Siehe "kubectl apply --validate=false"

    argocd.argoproj.io/sync-options: Validate=false

#### Selective Sync

Wird auf Applikationsebene gesetzt. Es dient dazu nur "OutOfSync" Ressourcen zu synchronisieren und wird verwendet,
wenn viele Ressourcen gleichzeitig synchronisiert würden und dies lange Zeit benötigt und / oder viel Kapazität des API
Servers benötigen würde.

#### Prune Last

Wird auf Applikations- oder Ressourcenebene angegeben. Mit diesem Parameter werden Ressourcen zuerst erstellt und nach
Abschluss der Erstellungs- und Updateoperationen wird erst das Pruning durchgeführt

    argocd.argoproj.io/sync-options: PruneLast=false

#### Replace Resources

Wird auf Applikations- oder Ressourcenebene angegeben. Durch diesen Parameter verwendet ArgoCD nicht das Verhalten von
"kubectl apply", welches Ressourcen nur neu erstellt / ändert, wenn sie geändert wurden.
<br>

    argocd.argoproj.io/sync-options: Replace=true

#### Fail on Shared Resource

Wird auf Applikationsebene gesetzt. Sollten zu synchronisierende Ressourcen für mehrere Applikationen zur Verfügung stehen,
werden diese normalerweise ausgerollt und eine Warnung angezeigt. Soll dieses Verhalten verhindert werden, muss diese Option
gesetzt werden.


### Deklarativer Ansatz

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
    repoURL: "https://github.com/argoproj/argocd-example-apps.git"
    targetRevision: HEAD
  syncPolicy:
    automated: # automated sync by default retries failed attempts 5 times with following delays between attempts ( 5s, 10s, 20s, 40s, 80s ); retry controlled using `retry` field.
      prune: true # Specifies if resources should be pruned during auto-syncing ( false by default ).
      selfHeal: true # Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected ( false by default ).
      allowEmpty: false # Allows deleting all application resources during automatic syncing ( false by default ).
    syncOptions:     # Sync options which modifies sync behavior
      - Validate=false # disables resource validation (equivalent to 'kubectl apply --validate=false') ( true by default ).
      - CreateNamespace=true # Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster.
      - PrunePropagationPolicy=foreground # Supported policies are background, foreground and orphan.
      - PruneLast=true # Allow the ability for resource pruning to happen as a final, implicit wave of a sync operation
      - RespectIgnoreDifferences=true # When syncing changes, respect fields ignored by the ignoreDifferences configuration
      - ApplyOutOfSyncOnly=true
      - Replace=true
      - FailOnSharedResources=true
    managedNamespaceMetadata: # Sets the metadata for the application namespace. Only valid if CreateNamespace=true (see above), otherwise it's a no-op.
      labels: # The labels to set on the application namespace
        any: label
        you: like
      annotations: # The annotations to set on the application namespace
        the: same
        applies: for
        annotations: on-the-namespace
---
```
Quelle: https://argo-cd.readthedocs.io/en/stable/user-guide/application-specification/#application-specification

### CLI

``argocd app create nginx-ingress --repo <repo-url> --helm-chart <chart-name> --revision <version>
--dest-namespace <namespace> --dest-server <server> --sync-policy automated --auto-prune``

