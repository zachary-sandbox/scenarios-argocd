# Step3 ApplicationSet with Git directory generator

Create a namespace:
```bash
kubectl create namespace git-dir-demo
```

Create ApplicationSet YAML:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: git-dir-demo
  namespace: argocd
spec:
  generators:
    - git:
        repoURL: https://github.com/argoproj/argocd-example-apps.git
        revision: HEAD
        directories:
          - path: kustomize-guestbook/*
  template:
    metadata:
      name: git-dir-{{path.basename}}
    spec:
      project: default
      source:
        repoURL: https://github.com/argoproj/argocd-example-apps.git
        targetRevision: HEAD
        path: {{path}}
      destination:
        server: https://kubernetes.default.svc
        namespace: git-dir-demo
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
```

Apply it:
```bash
kubectl apply -f git-dir-demo.yaml
```

Verify generated Applications:
```bash
argocd app list
```
