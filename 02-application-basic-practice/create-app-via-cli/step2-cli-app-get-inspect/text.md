# Step2 Inspect application with argocd app get
Run cli inspect command:
```bash
argocd app get guestbook-via-cli
```

This command prints:
‑ Application source / destination configuration
‑ Sync status, Health status
‑ Resources tree of managed kubernetes objects

You can also filter output with‑o json for scripting:
```bash
argocd app get guestbook-via-cli -o json
```
