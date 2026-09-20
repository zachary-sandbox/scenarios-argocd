# Step2 GitOps vs Traditional Delivery Mode

## Traditional CI Pipeline Pattern
CI builds container image, then pipeline executes imperative `kubectl apply` to modify cluster directly.

> Drawbacks:
> - Change history is NOT persisted in Git
> - Ad-hoc manual edits inside cluster cannot be tracked
> - Rollback process is error-prone.

## GitOps Pattern
1. CI pipeline only builds container images. CI updates image tag values inside Git manifest repository.
2. Argo-CD controller reads Git repository and applies changes into Kubernetes cluster.

Thinking points:
1. What are benefits when CI pipeline never directly touches Kubernetes API?
2. If user manually edits resources inside cluster, what will Argo-CD do with self-heal enabled?
