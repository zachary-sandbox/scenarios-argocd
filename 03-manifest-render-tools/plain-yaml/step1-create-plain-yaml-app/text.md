# Step1 Create Application from plain YAML directory

Create a test namespace:
```bash
kubectl create namespace plain-yaml-demo
```

Create an Application pointing to a plain YAML source. You can use a public example repo or your own fork:
```bash
argocd app create plain-yaml-app   --repo https://github.com/argoproj/argocd-example-apps.git   --path plain   --dest-server https://kubernetes.default.svc   --dest-namespace plain-yaml-demo   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Verify the Application exists:
```bash
argocd app list
```
