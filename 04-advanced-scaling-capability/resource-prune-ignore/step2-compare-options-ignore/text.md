# Step2 Ignore extraneous resources

Use annotation to ignore resources not managed by Git:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: manual-config
  namespace: prune-ignore-demo
  annotations:
    argocd.argoproj.io/compare-options: IgnoreExtraneous
```

This tells Argo CD:
- Do not compare this resource against Git
- Do not prune it even if it is not in Git

Create namespace:
```bash
kubectl create namespace prune-ignore-demo
```

Apply the ConfigMap manually and verify it is not pruned.
