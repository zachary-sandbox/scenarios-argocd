# Step3 Create Application from private source

Once credentials are configured, create an Application from the private source:
```bash
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: private-helm-guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: registry-1.docker.io
    chart: zachary404/helm-guestbook
    targetRevision: 0.1.0
    helm:
      releaseName: helm-guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: demo
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
```

Wait for sync:
```bash
argocd app wait private-helm-guestbook
```

Troubleshooting tips:
- Check repo-server logs for authentication failures
- Verify credential secret exists in argocd namespace
- Confirm network access to the private repository
