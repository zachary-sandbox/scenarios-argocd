# Step3 Global resource exclusions

You can exclude resource types globally in `argocd-cm` ConfigMap.

Example:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  resource.exclusions: |
    - apiGroups:
        - *
      kinds:
        - ConfigMap
      clusters:
        - *
```

This prevents Argo CD from managing or pruning excluded resources.

Caution:
Global exclusions affect all Applications.
Use them carefully for cluster-scoped or manually-managed resources.
