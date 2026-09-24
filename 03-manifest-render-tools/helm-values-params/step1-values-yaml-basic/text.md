# Step1 Use values.yaml

[https://github.com/zachary-sandbox/charts.git](https://github.com/zachary-sandbox/charts.git)

A typical values.yaml:

```
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

You can store values files in Git and let Argo CD render them.

Lab experimental steps

1. Git repo contains chart folder and environment-specific value files:

```
nginx-chart/
  Chart.yaml
  templates/
  values.yaml          # base default values
  values-dev.yaml      # dev environment override
  values-prod.yaml     # prod environment override
```

2. ArgoCD Application CR using `valueFiles` to load environment override file from Git

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-values-demo
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/charts.git
    targetRevision: HEAD
    path: bitnami/nginx
    helm:
      valueFiles:
        - values.yaml
        - values-prod.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: helm-values-demo
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

3. Apply and sync application

```
kubectl apply -f helm-values-demo.yaml -n argocd
argocd app sync helm-values-demo
```

4. Verify rendered configuration

```
kubectl get deployment -n helm-values-demo nginx -o yaml | grep replicas
```

Observation:
Later `valueFiles` override keys from earlier files. `values-prod.yaml` takes higher priority over base `values.yaml`.

Thinking question:
Why put values under version control instead of keeping them only in CI/CD variables?

Answer

Storing values.yaml in Git provides full version history, code review, audit traceability. Every configuration change is tracked via Git commit, you can view diff, revert to previous known-good state.

If values are only kept in CI/CD variables, there is no persistent change history inside Git. You lose audit trail, cannot review configuration changes via pull-request, and risk configuration drift between Git and actual deployed state.

For GitOps (ArgoCD), Git is the single source of truth. Keeping values in Git makes application configuration declarative and reproducible.

### Short summary (lab submission)

Version-controlled values bring change history, code review and audit capability. CI variables lack persistent traceability. GitOps treats Git as single source-of-truth for all configuration.

Thinking: When multiple `valueFiles` are configured, which file takes highest precedence?

Answer

When multiple entries exist in `valueFiles`, **files listed later in the list have higher precedence**. Later files override same keys defined in earlier files.

Example:

```
valueFiles:
  - values.yaml
  - values-prod.yaml
```

`values-prod.yaml` overrides keys from `values.yaml`.

### Short summary (lab submission)

Within `valueFiles` list, later files have higher precedence and overwrite duplicate configuration keys from earlier files.

Clean-up commands

```
argocd app delete helm-values-demo -y
kubectl delete ns helm-values-demo
```

>
> 完整块可直接复制粘贴写入 text.md，需要继续下一小节可以告诉我。