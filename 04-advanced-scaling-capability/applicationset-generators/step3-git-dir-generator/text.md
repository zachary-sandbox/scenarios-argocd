# Step3 ApplicationSet with Git directory generator

## Example 2: Git Directory Generator

Discover sub-directories inside git repo path, create one Application for each sub-folder.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: git-dir-appset
  namespace: argocd
spec:
  generators:
  - git:
      repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
      revision: release/v1.0.0
      directories:
        - path: applicationset-examples/guestbook/overlays/*
  template:
    metadata:
      name: "app-{{path.basename}}"
      namespace: argocd
    spec:
      project: default
      source:
        repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
        targetRevision: release/v1.0.0
        path: "{{path}}"
      destination:
        server: https://kubernetes.default.svc
        namespace: "{{path.basename}}"
      syncPolicy:
        syncOptions:
          - CreateNamespace=true
```

>
> Built-in git directory generator parameters:
>
>
> - `${path}`: full directory path in git
> - `${path.basename}`: last folder name of path

## Important behaviours

1. **Prune**: If you remove an element from list generator or delete git sub-directory, ApplicationSet will delete corresponding generated Application CR automatically.
2. Template placeholders use `${variable}` syntax.
3. ApplicationSet itself lives in `argocd` namespace. Generated child Applications also land in `argocd` namespace.
4. Difference compare with App-of-Apps:
    - App-of-Apps: store full static Application YAML files in Git.
    - ApplicationSet: use generator + template, do not write full Application manifests in Git; parameters are fed into template to produce Applications programmatically.

## Thinking: What are the two main components inside ApplicationSet spec?

<details>
<summary>Answer</summary>

Generators produce parameter sets; Template is Application CR template that substitutes parameters to generate child Application resources.

### Short summary (lab submission)

ApplicationSet consists of generators (provide parameters) and template (Application template for rendering child apps).

</details>

## Thinking: What is key difference between App-of-Apps pattern and ApplicationSet?

<details>
<summary>Answer</summary>

App-of-Apps stores complete static Application YAML manifests in Git repository.
ApplicationSet uses generators plus template, dynamically renders Application CRs from parameters, no static full Application yaml files required in git.

### Short summary (lab submission)

App-of-Apps uses static Application YAML in git. ApplicationSet dynamically generates Applications via generator + template substitution.

</details>

## Clean-up lab resources

```
kubectl delete applicationset guestbook-appset git-dir-appset -n argocd
argocd app delete guestbook-dev guestbook-staging guestbook-prod -y
kubectl delete namespace guestbook-dev guestbook-staging guestbook-prod
```
