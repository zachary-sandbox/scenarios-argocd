# Step1 Helm concepts for Argo CD

Helm charts are packaged Kubernetes applications.
Argo CD supports Helm by rendering templates into YAML manifests.

Key concepts:

- Chart: packaged application template
- Values: configurable inputs for chart customization
- Release: deployed instance of a chart
  Important:
  Argo CD does not use Helm v2 Tiller.
  It renders the chart locally inside repo-server and applies the resulting manifests.
  Reference: [https://argo-cd.readthedocs.io/en/stable/user-guide/helm/](https://argo-cd.readthedocs.io/en/stable/user-guide/helm/)

Example Application source section for Helm chart:

>
> Note:
>
> When consuming Helm chart from Git repo, use `path:` to point to chart directory inside git, do not use `chart:` field.
>
> When consuming chart from remote Helm repository, use `chart:` field and do not use `path:`.

Example Application: Helm chart stored inside Git repository 

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps
    targetRevision: HEAD
    path: helm-guestbook
    helm:
      releaseName: helm-guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: helm-guestbook
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

Example Application: Helm chart from remote Helm repository

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-remote-nginx
  namespace: argocd
spec:
  project: default
  source:
    # Remote Helm repository base URL (serves index.yaml)
    repoURL: https://charts.bitnami.com/bitnami
    chart: nginx
    targetRevision: 15.0.0
    helm:
      releaseName: nginx-remote
      # valueFiles: NOT available for remote helm repo
      values: |
        replicaCount: 1
        service:
          type: ClusterIP
      valuesObject:
        replicaCount: 2
      parameters:
        - name: service.type
          value: NodePort
  destination:
    server: https://kubernetes.default.svc
    namespace: helm-remote-nginx
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true

```