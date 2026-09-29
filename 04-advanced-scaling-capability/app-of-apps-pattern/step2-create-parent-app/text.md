# Step2 Create parent Application

Parent Application manifest (the root app, points to `children/` folder which contains child Application CRs)

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: parent-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: release/v1.0.0
    path: app-of-apps/children
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
```

Lab steps

1. Apply parent Application manifest to cluster.

```bash
kubectl apply -f parent-app.yaml -n argocd
```

2List applications, you will see parent app and all generated child apps

```bash
argocd app list
```

Observation:

- Parent Application only manages **Application CR resources**. It does not deploy business workload like Deployment or Service.
- Child Applications read their own source location from git and deploy real business kubernetes resources.
- When you add / delete child Application yaml inside git `children/` folder, parent app with `prune=true` will create or remove corresponding child Application CR in cluster.

>
> Important note: Resource security
> By default ArgoCD will not allow an Application to manage other Application CRs. You need to add resource override in ArgoCD configmap `argocd-cm`.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  resource.customizations: |
    argoproj.io/Application:
      health.lua: |
        health_status = { status = "Progressing", message = "Waiting for sync" }
        obj = json.decode(resource.object)
        if obj.status.sync.status == "Synced" then
          health_status = { status = "Healthy", message = "Synced" }
        elseif obj.status.sync.status == "OutOfSync" then
          health_status = { status = "Degraded", message = "OutOfSync" }
        end
        return health_status
```

Apply configmap change and restart argocd-repo-server pod to take effect.

```bash
kubectl rollout restart deployment argocd-repo-server -n argocd
```
