# Step1 Create Application from plain YAML directory

> Plain YAML source: Git folder contains raw Kubernetes YAML files, **no Helm Chart.yaml, no kustomization.yaml**. ArgoCD directly applies all *.yaml manifests found in target path.

## Git repo plain directory file example

Directory layout in git repository:

```
plain-yaml/
├── deployment.yaml
├── service.yaml
└── configmap.yaml
```

Corresponding declarative Application CR YAML (equivalent to argocd app create command):

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: plain-yaml-demo
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: release/v1.0.0
    # point path to overlay folder, NOT base folder
    path: plain-yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: plain-yaml-demo
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

Verify the Application exists:

```bash
argocd app list
```

Lab steps

1. Apply declarative manifest alternative:

```
kubectl apply -f plain-yaml-demo.yaml -n argocd
```

2. Check app status and wait for automated sync:

```
argocd app wait plain-yaml-demo
```

3. Verify deployed resources:

```
kubectl get all,configmap -n plain-yaml-demo
```

Observation:

ArgoCD scans the `plain-yaml/` path in git repo, reads all kubernetes yaml files, applies them directly to cluster. No helm rendering, no kustomize build.

> Important notes for plain yaml source
>
> 1. If you add new yaml file into git `plain/` folder, ArgoCD will automatically deploy new resource (when automated sync enabled).
> 2. If you delete a yaml file from git, `prune=true` makes ArgoCD delete corresponding resource from cluster.
> 3. `selfHeal=true`: If someone modifies resource manually in cluster, ArgoCD will revert it back to git state.
> 4. If folder contains `kustomization.yaml`, ArgoCD will treat it as Kustomize source, not plain yaml source.

## Thinking: What condition makes ArgoCD treat git path as plain yaml source instead of Kustomize source?

<details>
<summary>Answer</summary>

When target git path **does not contain kustomization.yaml**, ArgoCD treats it as plain YAML source and directly applies all discovered kubernetes manifest files.
If `kustomization.yaml` exists in path, ArgoCD switches to Kustomize mode and runs kustomize build.

### Short summary (lab submission)

No `kustomization.yaml` present in git path → plain yaml source. Presence of `kustomization.yaml` enables Kustomize rendering mode.

</details>

## Thinking: What is function of `prune: true` inside automated sync policy?

<details>
<summary>Answer</summary>

`prune: true` enables resource pruning. When a resource manifest is removed from Git repository, ArgoCD will delete that corresponding resource from Kubernetes cluster during sync. Without prune=true, deleted git manifests will not remove live cluster resources.

### Short summary (lab submission)

`prune=true` deletes cluster resources whose yaml no longer exists in git source.

</details>

Clean‑up lab resources

```
argocd app delete plain-yaml-demo -y
kubectl delete namespace plain-yaml-demo
```