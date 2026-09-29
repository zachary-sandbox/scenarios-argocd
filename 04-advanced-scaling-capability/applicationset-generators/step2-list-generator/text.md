# Step2 ApplicationSet with List generator

## Example 1: List Generator (one app per environment)

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: guestbook-appset
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - env: dev
            namespace: dev
          - env: staging
            namespace: staging
          - env: prod
            namespace: prod
  template:
    metadata:
      name: "guestbook-{{env}}"
      namespace: argocd
    spec:
      project: default
      source:
        repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
        targetRevision: release/v1.0.0
        path: "applicationset-examples/guestbook/overlays/{{env}}"
      destination:
        server: https://kubernetes.default.svc
        namespace: "{{namespace}}"
      syncPolicy:
        syncOptions:
          - CreateNamespace=true
        automated:
          prune: true
          selfHeal: true
```

Lab steps for List generator

```
kubectl apply -f applicationset-list.yaml -n argocd
argocd app list
```

Observation:
ApplicationSet automatically generates three Applications: `guestbook-dev`, `guestbook-staging`, `guestbook-prod`. Each substitutes `${env}` and `${namespace}` from list elements.

## Clean-up lab resources

```
kubectl delete applicationset guestbook-appset git-dir-appset -n argocd
argocd app delete guestbook-dev guestbook-staging guestbook-prod -y
kubectl delete namespace guestbook-dev guestbook-staging guestbook-prod
```