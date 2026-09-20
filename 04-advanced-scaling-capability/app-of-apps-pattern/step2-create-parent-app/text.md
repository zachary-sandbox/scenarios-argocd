# Step2 Create parent Application

Create a namespace for child apps:
```bash
kubectl create namespace app-of-apps-demo
```

Create a parent Application pointing to a Git directory containing child Application CRs:
```bash
argocd app create parent-app   --repo https://github.com/argoproj/argocd-example-apps.git   --path apps   --dest-server https://kubernetes.default.svc   --dest-namespace argocd   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for the parent to sync:
```bash
argocd app wait parent-app
```

List applications:
```bash
argocd app list
```
