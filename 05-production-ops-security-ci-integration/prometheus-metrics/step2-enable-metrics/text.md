# Step2 Enable metrics in argocd‑cm

By default metrics are enabled in modern Argo‑CD versions.
Verify argocd‑cm configmap:

```bash
kubectl get configmap argocd-cm -n argocd -o yaml
```

If you need disable auth for metrics endpoint (for prometheus scrape):

```
data:
  api.server.metrics.enabled: true
```

Restart api‑server deployment to apply changes:

```bash
kubectl rollout restart deployment argocd-api-server -n argocd
```
