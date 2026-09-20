# Step1 Enable automated sync policy
Patch existing application to add automated syncPolicy:
```bash
kubectl patch application cli‑demo‑app -n argocd --type merge -p '
{
  "spec": {
    "syncPolicy": {
      "automated": {
        "prune": true,
        "selfHeal": true
      }
    }
  }
}'
```

Inspect updated spec:
```bash
kubectl get application cli‑demo‑app -n argocd -o yaml
```

> Warning: Once enabled, Argo‑CD will autonomously change your cluster resources without manual click.
