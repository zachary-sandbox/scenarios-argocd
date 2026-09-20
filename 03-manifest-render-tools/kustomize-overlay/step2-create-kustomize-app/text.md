# Step2 Create Argo CD Application for Kustomize overlay

Create a namespace:
```bash
kubectl create namespace kustomize-demo
```

Create Application pointing to a Kustomize overlay directory:
```bash
argocd app create kustomize-app   --repo https://github.com/argoproj/argocd-example-apps.git   --path kustomize-guestbook/overlays/staging   --dest-server https://kubernetes.default.svc   --dest-namespace kustomize-demo   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for sync:
```bash
argocd app wait kustomize-app
```
