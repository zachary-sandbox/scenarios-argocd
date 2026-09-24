# Step2 Application CRD status fields

Two most important status sections:

1. **status.syncStatus**

- Synced: Live state matches git desired state
- OutOfSync: Live cluster resources diverge from git manifests

2. **status.healthStatus**

- Healthy: All resources are ready and pass health checks
- Progressing: Resources are being created/updating
- Degraded: Resources failed, error state

Inspect live application status with kubectl:

```
kubectl get application -n argocd -o yaml
```

## Thinking: Difference between OutOfSync and Degraded?

<details>
<summary>Answer</summary>

`OutOfSync` belongs to **sync status**. It describes whether the Kubernetes resources deployed in cluster exactly match the manifests stored in Git.

- OutOfSync: The live resources differ from Git desired state. It can be triggered by Git manifest changes, manual edits to cluster resources, or missing resources in the cluster. **The resources themselves may still be running fine.**
- When you perform sync, ArgoCD will update cluster resources to align with Git, and sync status will turn Synced.

`Degraded` belongs to **health status**. It describes whether the deployed workload is functioning correctly after the manifests have been applied to Kubernetes.

- Degraded means the resource is broken at runtime. Examples: Pod CrashLoopBackOff, invalid container image, missing config values, readiness probe failure.
- A Degraded application can still be **Synced**. ArgoCD successfully applied all YAML manifests from Git, but the workload fails runtime health checks.

#### Key distinction

- **OutOfSync**: Configuration mismatch between Git and cluster (manifest layer).
- **Degraded**: Runtime workload failure after manifests are applied (workload running layer).

Common combinations:

1. Synced + Healthy: Perfect state, manifests applied and workload works.
2. OutOfSync + Healthy: Git changed, but currently running Pods are still healthy.
3. Synced + Degraded: Manifests applied successfully, but workload crashes or fails health check.
4. OutOfSync + Degraded: Git state differs AND deployed resources are broken.

### Short summary (for lab submission)

OutOfSync indicates a divergence between Git desired manifests and live cluster resources (sync layer). Degraded means the deployed resources have runtime failures and fail health checks (health layer). An application can be Synced but Degraded, which means ArgoCD applied the YAML correctly, yet the workload does not run properly.

</details>