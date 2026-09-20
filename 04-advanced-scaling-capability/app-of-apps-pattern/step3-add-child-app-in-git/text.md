# Step3 Add child Application CR in Git

Fork the example repository to your own account.

Add a new child Application CR YAML file in the apps directory:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: child-app-1
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    targetRevision: HEAD
    path: plain
  destination:
    server: https://kubernetes.default.svc
    namespace: app-of-apps-demo
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Commit and push:
```bash
git add .
git commit -m add
