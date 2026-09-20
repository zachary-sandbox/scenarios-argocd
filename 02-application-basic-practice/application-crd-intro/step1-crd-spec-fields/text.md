# Step1 Application CRD spec main fields
## Core spec blocks
1. **spec.source**: Git repository source configuration
    - repoURL: git repository address
    - targetRevision: branch / tag / commit hash
    - path: sub‑directory path containing kubernetes manifests
2. **spec.destination**: target deployment location
    - server: target kubernetes cluster api‑server url
    - namespace: target namespace for resources to be deployed
3. **spec.syncPolicy**: sync behaviour rules
    - automated: enable auto sync
    - prune: delete resources removed from git
    - selfHeal: revert manual cluster edits back to git desired state

Example minimal Application yaml snippet:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: demo‑app
  namespace: argocd
spec:
  source:
    repoURL: https://github.com/xxx/demo.git
    targetRevision: main
    path: manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: demo‑ns
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Thinking question: What happens if you omit syncPolicy entirely?
