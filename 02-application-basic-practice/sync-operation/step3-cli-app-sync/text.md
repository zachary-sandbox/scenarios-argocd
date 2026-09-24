# Step3 Manual sync by argocd cli command

Simulate `OutOfSync`

```bash
kubectl scale deploy guestbook-via-cli -n guestbook-via-cli --replicas=5
```

Command to trigger sync:
```bash
argocd app sync guestbook-via-cli
```

After running sync command, watch application status real-time:
```bash
argocd app watch guestbook-via-cli
```

> Note: `argocd app sync` is imperative trigger, it does NOT modify Application CR yaml itself.
