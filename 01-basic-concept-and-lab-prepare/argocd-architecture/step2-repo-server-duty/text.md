# Step2 repo-server Responsibilities
repo-server runs as separate stateless service:
1. Clone target Git repository, supports private repository credentials (SSH keys / HTTPS username-password / Git personal access tokens). It caches cloned repositories to avoid repeated full clone operations.
2. Execute template rendering: kustomize build / helm template / jsonnet evaluation, convert declarative templates to raw Kubernetes manifests. It also resolves Helm values files, remote chart dependencies, Kustomize remote bases and patch overlays during rendering.
3. Return rendered manifest output back to application-controller via gRPC API.

Key points:
- application-controller **never directly access Git repositories**. All git operations are delegated to repo-server. The controller only receives final rendered YAML manifests from repo-server.
- Provides repository access isolation for multi-tenant scenarios. Different repository credentials are loaded inside repo-server; one tenant cannot access Git credentials belonging to another tenant.
- Repo-server runs rendering workload with minimal Kubernetes permissions, acting as a security sandbox to contain risks from malicious Helm charts or crafted manifests.

---

## Thinking: When Helm Chart is stored inside Git repository, how does Argo-CD produce final deployment YAML?

<details>
<summary>Answer</summary>

1. **Trigger request from application-controller**
   When reconciling an `Application` CR, application-controller sends a gRPC request to repo-server, including Git repo URL, commit SHA, chart path inside Git, Helm `values.yaml` overrides and Helm parameters. The controller does NOT pull Git code by itself.

2. **Git repository clone (repo-server)**
   repo-server fetches the target Git repository using the stored Git credentials. It checks out the specific commit SHA defined in the Application resource. The Helm chart files (`Chart.yaml`, `values.yaml`, template folder) are now available locally inside repo-server.

3. **Helm dependency download**
   repo-server executes `helm dependency build` to download chart dependencies. Dependencies can be local subcharts inside the Git repo or external Helm charts from Helm registries (if permitted by AppProject source whitelist).

4. **Render Helm templates**
   repo-server runs `helm template` (ArgoCD does NOT perform `helm install`). It combines:
- Chart built-in default `values.yaml`
- Custom values files stored in Git
- Inline value overrides defined in ArgoCD Application CR (`spec.source.helm.values`)
- Helm parameters (`--set` equivalent values)

Helm templating engine substitutes all Go template variables inside the chart’s template files and outputs raw Kubernetes YAML manifests.

5. **Filter and validate rendered manifests**
   repo-server performs basic validation on rendered YAML, removes Helm-specific metadata annotations, and assembles all Kubernetes resources into a manifest list.

6. **Return manifests to application-controller over gRPC**
   The final raw K8s manifests are sent back to application-controller. The controller then compares these desired manifests against live resources in the target Kubernetes cluster, detects drift/OutOfSync and performs sync operations.

### Short summary (for exam / lab submission)
ArgoCD delegates all work to repo-server. repo-server clones the Git repo at the specified commit, builds Helm dependencies, runs `helm template` with merged values to render raw Kubernetes manifests, then sends the final YAML back to application-controller for state comparison and synchronization. ArgoCD never uses Helm install; it only uses Helm’s template rendering function.

</details>
