# Übersicht

## GitOps
1. As code
    1. Infrastructure as code
    2. Configuration as code
    3. Saved in SCM
2. Collaboration and change control (Pull / Merge Requests)
3. CI/CD integration

### Advantages
- versioned
- Collaboration and code reviews
- automated CI/CD & CD
- Improved Security
    - Only CD system needs access to cluster
    - Pull model
- Rollbacks

## Features

Quelle: https://argo-cd.readthedocs.io/en/stable/#features

- Automated deployment of applications to specified target environments
- Support for multiple config management/templating tools (Kustomize, Helm, Jsonnet, plain-YAML)
- SSO Integration (OIDC, OAuth2, LDAP, SAML 2.0, Microsoft)
- Multi-tenancy and RBAC policies for authorization
- Rollback/Roll-anywhere to any application configuration committed in Git repository
- Health status analysis of application resources
- Automated configuration drift detection and visualization
- Automated or manual syncing of applications to its desired state
- Web UI which provides real-time view of application activity
- CLI for automation and CI integration
- Access tokens for automation
- PreSync, Sync, PostSync hooks to support complex application rollouts (e.g.blue/green & canary upgrades)
- Audit trails for application events and API calls
- Prometheus metrics
- Parameter overrides for overriding helm parameters in Git

## Core Concepts

Quelle: https://argo-cd.readthedocs.io/en/stable/core_concepts/#core-concepts

- **Application** A group of Kubernetes resources as defined by a manifest. This is a Custom Resource Definition (CRD).
- **Application source type** Which Tool is used to build the application.
- **Target state** The desired state of an application, as represented by files in a Git repository.
- **Live state** The live state of that application. What pods etc are deployed.
- **Sync status** Whether or not the live state matches the target state. Is the deployed application the same as Git says it should be?
- **Sync** The process of making an application move to its target state. E.g. by applying changes to a Kubernetes cluster.
- **Sync operation** status Whether or not a sync succeeded.
- **Refresh** Compare the latest code in Git with the live state. Figure out what is different.
- **Health** The health of the application, is it running correctly? Can it serve requests?
- **Tool** A tool to create manifests from a directory of files. E.g. Kustomize. See Application Source Type.
- **Configuration management tool** See Tool.
- **Configuration management plugin** A custom tool.

## Architektur

<img src="resources/argocd_architecture.webp" alt="argocd_architecture"/>

<span style="font-size:12px">Quelle: https://argo-cd.readthedocs.io/en/stable/#architecture</span>

Quelle: https://argo-cd.readthedocs.io/en/stable/operator-manual/architecture/#components
