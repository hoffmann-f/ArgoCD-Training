# Tracking Strategies

Hierbei handelt es sich um Konfigurationsmöglichkeiten für ArgoCD, um Änderungen in Repositories zu verfolgen.
<br>
Dabei ist es unabhängig, ob Git oder Helm Repos verwendet werden.

Es gibt folgende Möglichkeiten:
- Git Repo:
  - Commit SHA
  - Tags
  - Branches
  - Symbolische Referenzen (z.B. HEAD)
- Helm Repo (semantic versioning):
  - Spezifische Version: v1.2
  - Range: 1.2.* ; >=1.2.0 < 1.3.0
  - Latest: * ; >= 0.0.0

```yaml
...
spec:
  ....
  source:
    path: guestbook
    repoURL: "https://github.com/argoproj/argocd-example-apps.git"
    targetRevision: v1
---
```
**Git**

- Tag:``targetRevision: v1``
- BranchName: ``targetRevision: main``
- Symbolic Reference: ``targetRevision: HEAD``

**Helm**

- Specific Version: ``targetRevision: 1.0.1``
- Range: ``targetRevision: '>=2.1.5 <2.2.0'``
- latest Version: ``targetRevision: *``

