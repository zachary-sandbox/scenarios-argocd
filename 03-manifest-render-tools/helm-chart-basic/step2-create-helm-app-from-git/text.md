# Step2 Create Application from Helm chart in Git

Create namespace:
```bash
kubectl create namespace helm-basic-demo
```

Create Helm-based Application:
```bash
argocd app create helm-basic-app   --repo https://github.com/argoproj/argocd-example-apps.git   --path helm-guestbook   --dest-server https://kubernetes.default.svc   --dest-namespace helm-basic-demo   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for sync:
```bash
argocd app wait helm-basic-app
```
