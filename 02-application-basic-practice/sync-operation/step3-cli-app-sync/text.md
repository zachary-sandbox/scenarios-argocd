# Step3 Manual sync by argocd cli command
Command to trigger sync:
```bash
argocd app sync cli‑demo‑app
```

After running sync command, watch application status real‑time:
```bash
argocd app watch cli‑demo‑app
```

> Note: `argocd app sync` is imperative trigger, it does NOT modify Application CR yaml itself.
