# Step3 Declarative Application CR create (GitOps recommended)
Write file guestbook-declarative.yaml:
```yaml

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook-declarative
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook-declarative
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
```

Apply manifest directly to kubernetes api:
```bash
kubectl apply -f guestbook-declarative.yaml
```

> Best practice: store this Application CR yaml inside your git repository, fully declarative GitOps workflow.

