# Step2 Override Helm parameters in Argo CD

You can override Helm values directly in the Application spec.

Example declarative snippet:
```yaml
spec:
  source:
    helm:
      parameters:
        - name: replicaCount
          value: 3
        - name: image.tag
          value: 1.26
```

Or set via CLI:
```bash
argocd app set helm-basic-app --helm-set replicaCount=3
```

After the update, Argo CD re-renders the chart and syncs the change.
