# Application

Custom Resource Definition von ArgoCD Application:

https://argo-cd.readthedocs.io/en/stable/user-guide/application-specification/#application-specification

## Aufgabe 1.1

### Minimale Konfiguration
Schreibe eine minimale Konfiguration um mit ArgoCD die Testapplikation unter:
<code>
https://github.com/argoproj/argocd-example-apps.git
</code>
auszurollen.

ArgoCD ist im Namespace `argocd` installiert

Für die minimale Konfiguration werden folgende Angaben benötigt.
- destination
- source

<details>
 <summary>Hilfe für minimale Konfiguration</summary>

- apiVersion
- kind
- metadata
  - name
  - namespace
- spec
  - destination
    - namespace
    - server
  - source
    - path
    - repoURL
    - targetRevision
  - project

</details>

<details>
  <summary>Ausfüllhilfe</summary>

  **destination:**
    server ist der Kubernetes service des lokalen Clusters

  **source:**
    die benötigte targetRevision kann z.B. HEAD sein

</details>

Füge die geschriebene YAML per kubectl zu Kubernetes hinzu. Was fällt Dir auf?


## Aufgabe 1.2

Rolle die minimale Applikation via CLI aus.
<code>argocd</code> ist der Befehl für die CLI.

Starte mit <code>argocd login localhost:8080 --insecure</code>

Anzeigen der bestehenden Applikationen und deren Zustand ist über
```
argocd app list
```
möglich.

<details>
  <summary>Hilfe</summary>
  <code>argocd app create {name} --repo {repo-URL} --revision {git revision} --path {Pfad im Repo} 
--dest-server {Cluster-URL} --dest-namespace {namespace}</code>
</details>