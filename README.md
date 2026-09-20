# scenarios‑argocd
Scenarios of Declarative Argo CD Applications, Projects, Clusters and Repositories

# Argo‑CD Multi‑Stage Learning Outline (Reference official docs stable version)
> 6 progressive major phases. Each top‑level phase includes **phase objectives**, broken down into second‑level modules. Each phase outputs a JSON path manifest.

## Top‑level phases overview & objectives
### Phase 1: Basic Concepts and Lab Preparation
**Objectives**: Understand GitOps principles and Argo‑CD architecture; set‑up local Kubernetes lab environment; complete Argo‑CD installation, UI / CLI login; master core CRD concepts.

Second‑level modules:
1.1 gitops‑concept
1.2 argocd‑architecture
1.3 local‑k8s‑lab (kind / k3d)
1.4 install‑argocd
1.5 argocd‑cli‑ui‑login

```json
{
  "items": [
    { "path": "gitops‑concept" },
    { "path": "argocd‑architecture" },
    { "path": "local‑k8s‑lab" },
    { "path": "install‑argocd" },
    { "path": "argocd‑cli‑ui‑login" }
  ]
}
```

---
### Phase 2: Hands‑on Basics — Working with Application CR
**Objectives**: Master the Application CR resource; create applications via Web UI and CLI; comprehend Sync, OutOfSync, Health status; practice manual sync, automated sync, self‑heal; complete hands‑on exercises with official sample applications.

Second‑level modules:
2.1 application‑crd‑intro
2.2 create‑app‑via‑ui
2.3 create‑app‑via‑cli
2.4 sync‑operation
2.5 auto‑sync‑selfheal
2.6 sample‑guestbook

```json
{
  "items": [
    { "path": "application‑crd‑intro" },
    { "path": "create‑app‑via‑ui" },
    { "path": "create‑app‑via‑cli" },
    { "path": "sync‑operation" },
    { "path": "auto‑sync‑selfheal" },
    { "path": "sample‑guestbook" }
  ]
}
```

---
### Phase 3: Manifest Rendering Tools
**Objectives**: Learn manifest rendering methods supported by Argo‑CD: plain YAML, Kustomize, Helm; understand values files and overlays; configure private Git and Helm repositories.

Second‑level modules:
3.1 plain‑yaml
3.2 kustomize‑overlay
3.3 helm‑chart‑basic
3.4 helm‑values‑params
3.5 private‑git‑helm‑repo

```json
{
  "items": [
    { "path": "plain‑yaml" },
    { "path": "kustomize‑overlay" },
    { "path": "helm‑chart‑basic" },
    { "path": "helm‑values‑params" },
    { "path": "private‑git‑helm‑repo" }
  ]
}
```

---
### Phase 4: Advanced Scaling Capabilities
**Objectives**: Core capabilities for production‑scale adoption: App‑of‑Apps pattern, ApplicationSet, multi‑cluster management, Sync Hooks, resource ignore rules, resource pruning (prune).

Second‑level modules:
4.1 app‑of‑apps‑pattern
4.2 applicationset‑generators
4.3 multi‑cluster‑manage
4.4 sync‑hooks‑pre‑post
4.5 resource‑prune‑ignore
4.6 argocd‑self‑manage

```json
{
  "items": [
    { "path": "app‑of‑apps‑pattern" },
    { "path": "applicationset‑generators" },
    { "path": "multi‑cluster‑manage" },
    { "path": "sync‑hooks‑pre‑post" },
    { "path": "resource‑prune‑ignore" },
    { "path": "argocd‑self‑manage" }
  ]
}
```

---
### Phase 5: Production Operations, Security & CI Integration
**Objectives**: Production‑grade configuration: RBAC authorization, SSO/OIDC authentication, notification system, Prometheus metrics, high‑availability deployment, troubleshooting; build an end‑to‑end GitOps workflow integrated with Jenkins CI pipelines.

Second‑level modules:
5.1 rbac‑permission
5.2 sso‑oidc‑dex
5.3 notifications
5.4 prometheus‑metrics
5.5 ha‑install‑upgrade
5.6 troubleshooting
5.7 jenkins‑argocd‑gitops

```json
{
  "items": [
    { "path": "rbac‑permission" },
    { "path": "sso‑oidc‑dex" },
    { "path": "notifications" },
    { "path": "prometheus‑metrics" },
    { "path": "ha‑install‑upgrade" },
    { "path": "troubleshooting" },
    { "path": "jenkins‑argocd‑gitops" }
  ]
}
```

---
### Optional Extension Phase (Phase 6, elective): Argo Ecosystem Integrations
**Objectives**: Work with progressive delivery via Argo Rollouts; implement custom manifest rendering with ConfigManagementPlugin.

Second‑level modules:
6.1 argorollouts‑canary‑bluegreen
6.2 config‑management‑plugin

```json
{
  "items": [
    { "path": "argorollouts‑canary‑bluegreen" },
    { "path": "config‑management‑plugin" }
  ]
}
```

## Create Directories for ArgoCD Scenarios Learning
```text
argo‑cd‑learn/
├─ 01‑basic‑concept‑and‑lab‑prepare
│  ├─ gitops‑concept
│  ├─ argocd‑architecture
│  ├─ local‑k8s‑lab
│  ├‑ install‑argocd
│  └‑ argocd‑cli‑ui‑login
├‑ 02‑application‑basic‑practice
│  ├‑ application‑crd‑intro
│  ├‑ create‑app‑via‑ui
│  ├‑ create‑app‑via‑cli
│  ├‑ sync‑operation
│  ├‑ auto‑sync‑selfheal
│  └‑ sample‑guestbook
├‑ 03‑manifest‑render‑tools
│  ├‑ plain‑yaml
│  ├‑ kustomize‑overlay
│  ├‑ helm‑chart‑basic
│  ├‑ helm‑values‑params
│  └‑ private‑git‑helm‑repo
├‑ 04‑advanced‑scaling‑capability
│  ├‑ app‑of‑apps‑pattern
│  ├‑ applicationset‑generators
│  ├‑ multi‑cluster‑manage
│  ├‑ sync‑hooks‑pre‑post
│  ├‑ resource‑prune‑ignore
│  └‑ argocd‑self‑manage
├‑ 05‑production‑ops‑security‑ci‑integration
│  ├‑ rbac‑permission
│  ├‑ sso‑oidc‑dex
│  ├‑ notifications
│  ├‑ prometheus‑metrics
│  ├‑ ha‑install‑upgrade
│  ├‑ troubleshooting
│  └‑ jenkins‑argocd‑gitops
└‑ 06‑argo‑ecosystem‑extension
   ├‑ argorollouts‑canary‑bluegreen
   └‑ config‑management‑plugin
```

```bash
#!/bin/bash
#!/bin/bash
mkdir -p \
"01-basic-concept-and-lab-prepare"/{gitops-concept,argocd-architecture,local-k8s-lab,install-argocd,argocd-cli-ui-login} \
"02-application-basic-practice"/{application-crd-intro,create-app-via-ui,create-app-via-cli,sync-operation,auto-sync-selfheal,sample-guestbook} \
"03-manifest-render-tools"/{plain-yaml,kustomize-overlay,helm-chart-basic,helm-values-params,private-git-helm-repo} \
"04-advanced-scaling-capability"/{app-of-apps-pattern,applicationset-generators,multi-cluster-manage,sync-hooks-pre-post,resource-prune-ignore,argocd-self-manage} \
"05-production-ops-security-ci-integration"/{rbac-permission,sso-oidc-dex,notifications,prometheus-metrics,ha-install-upgrade,troubleshooting,jenkins-argocd-gitops} \
"06-argo-ecosystem-extension"/{argorollouts-canary-bluegreen,config-management-plugin}
```