# Step1 Imperative create application with argocd app create
Sample command:
```bash
argocd app create cli‑demo‑app \
  --repo https://github.com/argoproj/argocd‑example‑apps.git \
  --path guestbook \
  --dest‑server https://kubernetes.default.svc \
  --dest‑namespace cli‑demo‑ns \
  --project default
```

After executing command, list all applications:
```bash
argocd app list
```
