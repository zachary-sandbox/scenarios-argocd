# Step3 Declarative Application CR create (GitOps recommended)
Write file app‑declarative.yaml:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: yaml‑demo‑app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd‑example‑apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: yaml‑demo‑ns
```

Apply manifest directly to kubernetes api:
```bash
kubectl apply -f app‑declarative.yaml
```

> Best practice: store this Application CR yaml inside your git repository, fully declarative GitOps workflow.
