# Step1 Five Core Components
## application-controller
Argo-CD main controller. Watches Application CR resources continuously. Compares desired Git state against live Kubernetes resources, detects OutOfSync status and executes sync actions. It reconciles the Application custom resource, computes drift between the target state stored in Git and actual live state inside the Kubernetes cluster, triggers sync operations, and updates application health & sync status back into the Application CR status field. It also handles pruning of orphaned resources, resource health checks, and sync hooks.

## repo-server
Independent stateless service. Clones Git repositories, runs kustomize build / helm template / jsonnet rendering to produce native Kubernetes YAML manifests. It isolates manifest rendering workload away from the main controller. It fetches Git source artifacts, parses Helm values, resolves remote bases, renders the final K8s manifests, and returns rendered resources back to the controller via gRPC. Provides security isolation, separate from controller process.

## argocd-api-server
REST API backend for Web UI and argocd CLI. Responsible for authentication, authorization request handling, serving application & cluster metadata, exposing API endpoints for UI/CLI operations such as login, create/update/delete Application, trigger manual sync, view application logs and resource tree. It validates user permissions before forwarding requests to the controller or repo-server.

## dex
Identity broker, integrates external identity providers such as OIDC / LDAP / GitHub / GitLab SSO. It acts as an intermediary between ArgoCD and external authentication systems, converts external identity tokens into ArgoCD compatible JWT tokens, enabling single sign-on for ArgoCD UI and CLI without storing user passwords inside ArgoCD.

## redis
In-memory cache for repository metadata and cluster resource status, improves query performance. It caches Git repository commit information, rendered manifest results, live resource state snapshots, and reduces repeated Git clone and heavy manifest rendering overhead, lowering pressure on repo-server and Kubernetes API server.

---

## Thinking question: Why repo-server logic is not embedded directly inside application-controller?

<details>
<summary>Answer</summary>

There are four core reasons: **security isolation, resource & failure isolation, separation of concerns, and horizontal scalability**.

1. **Security Boundary Isolation (most critical)**
   Manifest rendering (Helm template, Kustomize, Jsonnet) is a high-risk attack surface. Malicious Helm charts or crafted Kustomize manifests can execute arbitrary code during rendering.
   If repo rendering code runs inside application-controller, a successful exploit would compromise the main controller process, which holds Kubernetes write permissions to deploy resources into your clusters.
   By splitting out repo-server as a separate stateless component with minimal permissions, we implement a **security sandbox**: repo-server only pulls Git repos and renders manifests. Even if repo-server gets compromised, the attacker cannot directly access the controller’s Kubernetes service account credentials to modify cluster resources. This is the primary design motivation.

2. **Failure & Resource Isolation**
   Manifest rendering can be CPU/memory heavy: large repositories, complex Helm charts, thousands of Kubernetes objects consume lots of compute.
   If embedded inside the controller, heavy rendering jobs can OOM or crash the main reconciliation loop of application-controller. This would break all application syncing for the whole ArgoCD instance.
   Separating repo-server means rendering workloads consume dedicated resources. Rendering failures or resource exhaustion only impact repo-server, and the core controller reconciliation remains stable.

3. **Separation of Concerns**
   The application-controller’s core responsibility is reconciliation: compare desired state vs live state, manage sync, health checks and resource pruning.
   Repo-server only handles source artifact retrieval and manifest rendering. Splitting these two functions keeps each component simple, easier to maintain, test, and upgrade independently.

4. **Independent Horizontal Scaling**
   Manifest rendering workload is often the bottleneck in large ArgoCD environments.
   You can scale repo-server replicas independently when you have many applications and heavy chart rendering load, without scaling the application-controller. If merged into one process, you have to scale everything together, wasting resources.

### Short summary (for exam submission)
Repo-server is separated mainly for security sandboxing. Manifest rendering is high-risk, and isolating it limits blast radius if malicious charts are exploited. It also separates heavy rendering workload from the core reconciliation logic, prevents rendering workloads from crashing the main controller, and allows independent scaling of manifest rendering capacity.

</details>


