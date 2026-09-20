# Step1 Deploy guestbook sample application
Create guestbook application resource pointing to official example repository:
```bash
argocd app create guestbook‑app \
  --repo https://github.com/argoproj/argocd‑example‑apps.git \
  --path guestbook \
  --dest‑server https://kubernetes.default.svc \
  --dest‑namespace guestbook‑ns \
  --project default \
  --sync‑policy automated --sync‑policy prune=true --sync‑policy self‑heal=true
```

Wait application reach Synced and Healthy status:
```bash
argocd app wait guestbook‑app
```

Verify guestbook pods are running:
```bash
kubectl get pods -n guestbook‑ns
```
