# Step3 Use custom plugin inside Application CR

Create Application that references custom config‑management‑plugin:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cmp‑demo‑app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: [https://github.com/xxx/custom](https://github.com/xxx/custom)‑plugin‑source.git
    targetRevision: HEAD
    path: ./
    plugin:
      name: my‑custom‑render‑plugin
  destination:
    server: [https://kubernetes.default.svc](https://kubernetes.default.svc)
    namespace: cmp‑demo‑ns
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Apply Application:
```bash
kubectl apply -f cmp‑demo‑app.yaml
```

Debug render output:
Check repo‑server pod logs for plugin stdout / stderr render output.
If render error occurs, Application will go into Unknown status.
