# Step3 End-to-End Full Workflow
1. Developer commits manifest changes into Git repository (update Desired State).
2. Argo-CD repo-server periodically fetches Git repository and renders Kubernetes manifests.
3. application-controller receives rendered manifests, compares against resources currently living inside Kubernetes cluster.
4. Any mismatch will mark Application status as `OutOfSync`.
5. Manual Sync trigger OR Auto-sync policy applies desired manifests into Kubernetes cluster.
6. Cluster resources get updated, Live State aligns to Desired State. Application status becomes Synced.

Important status definitions:
- Synced: Git desired state is fully applied into target Kubernetes cluster.
- OutOfSync: Live cluster state diverges from Git desired definition.
- Healthy: All application resources pass health checks and become ready.
