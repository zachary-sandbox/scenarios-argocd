# Step3 End-to-End Full Workflow
1. Developer commits manifest changes into Git repository (update Desired State). Git acts as the single source of truth; every configuration change must be tracked via Git commit and version controlled.
2. Argo-CD repo-server periodically fetches Git repository and renders Kubernetes manifests. It uses stored Git credentials to pull the target commit, executes Helm template / kustomize build to resolve templates and produce raw K8s manifests.
3. application-controller receives rendered manifests, compares against resources currently living inside Kubernetes cluster. It queries Kubernetes API server to collect live state of all related resources.
4. Any mismatch will mark Application status as `OutOfSync`. Mismatch includes added resources, deleted resources, changed spec fields, or missing resources in cluster.
5. Manual Sync trigger OR Auto-sync policy applies desired manifests into Kubernetes cluster. During sync, ArgoCD can execute sync hooks, create/update/delete resources, and prune orphaned resources if prune policy is enabled.
6. Cluster resources get updated, Live State aligns to Desired State. Application status becomes Synced. After sync completes, controller continues running health checks for all resources.

Important status definitions:
- **Synced**: Git desired state is fully applied into target Kubernetes cluster. The set and spec of live resources exactly match rendered manifests from Git. *Synced only describes whether the configuration has been applied successfully, it does NOT mean the workload is ready.*
- **OutOfSync**: Live cluster state diverges from Git desired definition. This happens when Git manifest changed, or someone manually modified Kubernetes resources directly in cluster (drift).
- **Healthy**: All application resources pass health checks and become ready. For example, Deployment has sufficient ready replicas, Pods are running, Service endpoints are available, Ingress is ready.

> Key distinction: `Synced` ≠ `Healthy`
> - Synced: configuration has been pushed to Kubernetes API.
> - Healthy: the deployed workload is running and functional.
    > A common scenario: Synced but Unhealthy — manifests applied successfully, but Pod crashes or image pull fails.

## Thinking Question
If an application shows `Synced` but `Unhealthy`, what does this mean? Give 2 typical root causes.

<details>
<summary>Answer</summary>

It means ArgoCD has successfully applied all YAML manifests from Git to the Kubernetes cluster (configuration is synced), but the deployed resources are not working properly.
Typical causes:
1. Wrong container image tag or image pull secret missing → ImagePullBackOff, Pod cannot start.
2. Misconfigured resource spec (wrong port, invalid env variable, incorrect volume mount). The YAML is accepted by Kubernetes API, but the workload cannot run normally.

### Short summary for lab submission:
`Synced` means desired manifests from Git are applied to the cluster. `Unhealthy` indicates the Kubernetes resources themselves fail readiness/health checks after creation. It proves GitOps config was deployed, but runtime workload has issues.

</details>