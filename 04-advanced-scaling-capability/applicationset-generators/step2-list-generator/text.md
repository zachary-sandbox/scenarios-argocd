# Step2 ApplicationSet with List generator

Create a namespace:
```bash
kubectl create namespace appsets-demo
```

Create ApplicationSet YAML:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: list-generator-demo
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - env: dev
            namespace: appsets-demo
          - env: staging
            namespace: appsets-demo
  template:
    metadata:
      name: list-demo-{{env}}
    spec:
      project: default
      source:
        repoURL: https://github.com/argoproj/argocd-example-apps.git
        targetRevision: HEAD
        path: plain
      destination:
        server: https://kubernetes.default.svc
        namespace: {{namespace}}
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
```

Apply it:
```bash
kubectl apply -f list-generator-demo.yaml
```

Verify generated Applications:
```bash
argocd app list
```
