# Step2 repo-server Responsibilities
repo-server runs as separate stateless service:
1. Clone target Git repository, supports private repository credentials.
2. Execute template rendering: kustomize build / helm template, convert templates to raw Kubernetes manifests.
3. Return rendered manifest output back to application-controller.

Key points:
- application-controller **never directly access Git repositories**. All git operations are delegated to repo-server.
- Provides repository access isolation for multi-tenant scenarios.

Thinking: When Helm Chart is stored inside Git repository, how does Argo-CD produce final deployment YAML?
