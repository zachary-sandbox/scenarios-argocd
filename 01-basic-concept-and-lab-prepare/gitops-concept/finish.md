### ✅ WELL DONE !
Completed lab module: gitops-concept GitOps core concepts

#### 📝 Recap Notes
1. Git acts as **single source-of-truth**. All Kubernetes resource manifests are version-controlled inside Git repositories.
2. Desired State: target cluster definition described by YAML files stored in Git repository.
3. Live State: real-world resource status currently running inside your Kubernetes cluster.
4. Controller continuously compares desired state against live state. Mismatch is marked as `OutOfSync`.
5. Compared with imperative `kubectl apply`: GitOps provides full audit trail, change history, simple rollback capability.

Next lab module: `argocd-architecture`.
