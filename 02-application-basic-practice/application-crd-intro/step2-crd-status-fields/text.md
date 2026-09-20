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
```bash
kubectl get application -n argocd -o yaml
```

Thinking: Difference between OutOfSync and Degraded?
