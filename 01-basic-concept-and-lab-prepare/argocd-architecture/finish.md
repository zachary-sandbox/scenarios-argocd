### ✅ WELL DONE !
Completed lab module: argocd-architecture architecture components and workflow

📝 Recap Notes
1. application-controller: core controller, compares desired Git state vs live cluster state, detects OutOfSync events.
2. repo-server: clones Git repositories, renders Kustomize / Helm templates into raw Kubernetes manifests, provides security isolation for repository access.
3. api-server: unified REST API entry point for Web UI and argocd CLI, handles authentication and authorization.
4. dex: identity proxy for SSO integration. redis: caching for repository and cluster status data.
5. Full workflow: Git commit → repo-server fetch & render manifests → controller state comparison → sync resources into Kubernetes.

Next lab module: `local-k8s-lab` to provision local Kubernetes lab environment.
