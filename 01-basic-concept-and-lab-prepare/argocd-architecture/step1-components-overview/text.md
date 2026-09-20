# Step1 Five Core Components
1. **application-controller**: Argo-CD main controller. Watches Application CR resources continuously. Compares desired Git state against live Kubernetes resources, detects OutOfSync and executes sync actions.
2. **repo-server**: Independent stateless service. Clones Git repositories, runs kustomize build / helm template to produce native Kubernetes YAML manifests. Provides security isolation, separate from controller process.
3. **argocd-api-server**: REST API backend for Web UI and argocd CLI. Responsible for authentication, authorization request handling.
4. **dex**: Identity broker, integrates external identity providers such as OIDC / LDAP / GitHub.
5. **redis**: In-memory cache for repository metadata and cluster resource status, improves query performance.

Thinking question: Why repo-server logic is not embedded directly inside application-controller?
