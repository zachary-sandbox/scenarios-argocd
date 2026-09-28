# Step2 Create Argo CD Application for Kustomize overlay


> Important for ArgoCD:
>
> When using Kustomize source in ArgoCD Application CR, `spec.source.path` points to **overlay directory** (e.g `k8s/overlays/prod`), ArgoCD repo-server internally runs kustomize build to render final manifests.

ArgoCD Application example using Kustomize overlay from Git repo

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kustomize-demo
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: release/v1.0.0
    # point path to overlay folder, NOT base folder
    path: kustomize-examples/k8s/overlays/prod
  destination:
    server: https://kubernetes.default.svc
    namespace: prod
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

Lab steps

1. Apply the ArgoCD application manifest

```bash
kubectl apply -f kustomize-demo.yaml -n argocd
```

2. Trigger sync

```bash
argocd app sync kustomize-demo
```

3. Inspect final rendered resources

```bash
kubectl get deployment -n prod guestbook-ui -o yaml
```

Observation:
Resources come from `base/`, while replicas, namespace, resource limits are injected by `overlays/prod`. Base files remain untouched; all environment customizations live inside overlay.
