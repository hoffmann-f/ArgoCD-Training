# Application Sets

Ein ApplicationSet ist ein Controller, welcher die CRD `ApplicationSet` unterstützt.
Ein ApplicationSet ermöglicht, sowohl die Automatisierung, als auch eine größere Flexibilität im Umgang mit Applications.

## Use cases

- Ausrollen eines Manifests, Helm Charts zu mehreren Applikationen.
- Multitenancy Support erlaubt Nutzern die Möglichkeit selbständig Applikationen in Cluster / Namespace zu deployen, ohne Admins.

## Wie funktioniert es

Das ApplicatonSet ist ausschließlich für das Erstellen, Aktualisieren und Löschen von Application CRDs im ArgoCD Namespace
zuständig.
<br>
Damit modifiziert es auch keine Kubernetes Ressourcen. Dies wird vom Application Controller durchgeführt.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: test-hello-world-appset
  namespace: argocd
spec:
  # See docs for available generators and their specs.
  generators:
  - list:
      elements:
      - cluster: https://kubernetes.default.svc
  # Determines whether go templating will be used in the `template` field below.
  goTemplate: false
  # Optional list of go templating options, see https://pkg.go.dev/text/template#Template.Option
  # This is only relevant if `goTemplate` is true
  goTemplateOptions: ["missingkey="]
  # These fields are identical to the Application spec.
  template:
    metadata:
      name: test-hello-world-app
    spec:
      project: my-project
  # This sync policy pertains to the ApplicationSet, not to the Applications it creates.
  syncPolicy:
    # Determines whether the controller will delete Applications when an ApplicationSet is deleted.
    preserveResourcesOnDeletion: false
  # Alpha feature to determine the order in which ApplicationSet applies changes.
  strategy:
  # This field lets you define fields which should be ignored when applying Application resources. This is helpful if you
  # want to use ApplicationSets to create apps, but also want to allow users to modify those apps without having their
  # changes overwritten by the ApplicationSet.
  ignoreApplicationDifferences:
  - jsonPointers:
    - /spec/source/targetRevision
  - name: some-app
    jqPathExpressions:
    - .spec.source.helm.values
```

Quelle: https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/applicationset-specification/#applicationset-specification

