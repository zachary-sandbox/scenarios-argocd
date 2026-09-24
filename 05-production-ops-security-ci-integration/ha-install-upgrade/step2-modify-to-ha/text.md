# Step2 Modify to HA replicas

Check current replicas:

```bash
kubectl get deployment -n argocd
```

Scale api-server:

```bash
kubectl scale deployment argocd-api-server -n argocd --replicas=3
```

Scale repo-server:

```bash
kubectl scale deployment argocd-repo-server -n argocd --replicas=3
```

For full production HA you need to switch redis from single-pod to redis-ha with sentinel.
Reference official HA manifest for complete production HA setup.
