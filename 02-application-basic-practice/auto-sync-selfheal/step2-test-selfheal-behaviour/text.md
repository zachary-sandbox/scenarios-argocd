# Step2 Test selfHeal behaviour
Again manually modify deployment replica count on cluster:
```bash
kubectl scale deployment -n cli‑demo‑ns guestbook‑ui --replicas=10
```

Observe replicas value: after short reconciliation interval, Argo‑CD self‑heal will revert replicas back to git manifest defined value.

Check deployment replica status repeatedly:
```bash
kubectl get deployment -n cli‑demo‑ns guestbook‑ui
```

> selfHeal protects cluster from out‑of‑band manual modifications.
