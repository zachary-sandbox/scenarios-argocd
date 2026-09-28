# Step3 Multiple values files

1. Git repo contains chart folder and environment-specific value files:

```
helm-guestbook/
  Chart.yaml
  templates/
  values.yaml          # base default values
  values-production.yaml     # production environment override
```

2. ArgoCD Application CR using `valueFiles` to load environment override file from Git

`helm-guestbook-multi-values.yaml`

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-guestbook-multi-values
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
        - values-production.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: helm-guestbook-multi-values
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

3. Apply and sync application

```bash
kubectl apply -f helm-guestbook-multi-values.yaml -n argocd
argocd app sync helm-guestbook-multi-values
```

4. Verify rendered configuration

```bash
kubectl get deployment -n helm-guestbook-multi-values -o yaml | grep replicas
```

Observation:
Later `valueFiles` override keys from earlier files. `values-production.yaml` takes higher priority over base `values.yaml`.

## Thinking: Why put values under version control instead of keeping them only in CI/CD variables?

<details>
<summary>Answer</summary>

Storing values.yaml in Git provides full version history, code review, audit traceability. Every configuration change is tracked via Git commit, you can view diff, revert to previous known-good state.

If values are only kept in CI/CD variables, there is no persistent change history inside Git. You lose audit trail, cannot review configuration changes via pull-request, and risk configuration drift between Git and actual deployed state.

For GitOps (ArgoCD), Git is the single source of truth. Keeping values in Git makes application configuration declarative and reproducible.

### Short summary (lab submission)

Version-controlled values bring change history, code review and audit capability. CI variables lack persistent traceability. GitOps treats Git as single source-of-truth for all configuration.

</details>

## Thinking: When multiple `valueFiles` are configured, which file takes highest precedence?

<details>
<summary>Answer</summary>

When multiple entries exist in `valueFiles`, **files listed later in the list have higher precedence**. Later files override same keys defined in earlier files.

Example:

```
valueFiles:
  - values.yaml
  - values-production.yaml
```

`values-production.yaml` overrides keys from `values.yaml`.

### Short summary (lab submission)

Within `valueFiles` list, later files have higher precedence and overwrite duplicate configuration keys from earlier files.

</details>

## Clean-up commands

```
argocd app delete helm-guestbook -y
kubectl delete ns helm-guestbook
```
