# Step1 Use values.yaml

A typical values.yaml:

```yaml
replicaCount: 2
image:
  repository: nginx
  tag: 1.25
service:
  type: ClusterIP
```

Helm templates use these values:

```
replicas: {{ .Values.replicaCount }}
```

Lab experimental steps

1. Git repo contains chart folder and environment-specific value files:

```
helm-guestbook/
  Chart.yaml
  templates/
  values.yaml          # base default values
  values-production.yaml     # prod environment override
```

2. ArgoCD Application CR using `valueFiles` to load environment override file from Git

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: HEAD
    path: helm-guestbook
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: helm-guestbook
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

3. Apply and sync application

```bash
kubectl apply -f helm-guestbook.yaml -n argocd
argocd app sync helm-guestbook
```

4. Verify rendered configuration

```bash
kubectl get deployment -n helm-guestbook -o yaml | grep replicas
```