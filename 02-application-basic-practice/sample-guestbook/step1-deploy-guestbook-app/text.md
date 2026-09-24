# Step1 Deploy guestbook sample application
Create guestbook application resource pointing to official example repository:
```bash
argocd app create guestbook-via-cli --repo https://github.com/zachary-sandbox/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook-via-cli --project default --sync-option CreateNamespace=true --auto-prune --self-heal
```

Wait application reach Synced and Healthy status:
```bash
argocd app wait guestbook-via-cli
```

Verify guestbook pods are running:
```bash
kubectl get pods -n guestbook-via-cli
```
