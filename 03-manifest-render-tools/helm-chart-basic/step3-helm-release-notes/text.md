# Step3 Review Helm release behavior

After sync, check deployed resources:

```bash
kubectl get all -n helm-guestbook
```

Consider these points:

1. Each Argo CD Application corresponds to one logical Helm release.
2. Changes in values or chart version will generate new rendered manifests.
3. Argo CD manages the lifecycle of the rendered Kubernetes resources.

>
> Important difference vs native Helm CLI:
> ArgoCD **does not store Helm release history secrets** (no `sh.helm.release.v1.*` Secrets). It only runs `helm template` to render manifests, then applies raw YAML to Kubernetes. Rollback is controlled by changing Git `targetRevision` / values, not by Helm’s built‑in release history.

Observation steps:

1. Modify one helm value inside Application CR e.g. change `replicaCount`

```bash
kubectl patch application helm-guestbook -n argocd --type merge -p '
{
  "spec": {
    "source": {
      "helm": {
        "valuesObject": {
          "replicaCount": 3
        }
      }
    }
  }
}'
```

2. Trigger sync and observe deployment replica change

```bash
argocd app sync helm-guestbook
kubectl get deployment -n helm-guestbook
```

3. Check for helm release Secrets

```bash
kubectl get secrets -n helm-guestbook | grep helm.release
```

Observation: No helm release history secrets exist in namespace. ArgoCD does not use Helm’s native release storage mechanism.

## Thinking question:
### 1. Why is Helm rendering useful compared to maintaining plain YAML for every environment?

<details>
<summary>Answer</summary>

Plain YAML requires you to maintain separate copies of manifest for dev, staging, production. Duplicate YAML leads to copy‑paste errors and heavy maintenance overhead.

Helm charts provide reusable template logic. You maintain one single set of chart templates, and use different `values` / `valueFiles` to customize configuration per‑environment. Environment‑specific parameters are separated from base template logic.

ArgoCD renders the chart with corresponding values to produce final Kubernetes manifests at runtime. This reduces duplication, improves consistency, and makes environment management easier.

#### Short summary (lab submission)

Helm enables re‑usable templates: maintain one chart, apply different values for different environments, avoid duplicating full plain‑YAML copies for each environment.

</details>

### ArgoCD uses helm rendering, but you cannot use `helm rollback` command to rollback ArgoCD Helm‑based application. Why?

<details>
<summary>Answer</summary>

Native Helm CLI stores release history inside Kubernetes Secrets (`sh.helm.release.v1.*`), `helm rollback` relies on those stored release snapshots.

ArgoCD only executes `helm template` (client‑side rendering). It **does not create or persist Helm release history Secrets**. There is no Helm release snapshot stored in cluster. Rollback must be done by reverting Git change: restore old chart version / old values in Application CR and sync again.

#### Short summary (lab submission)

ArgoCD runs `helm template` only and does not save Helm release history secrets. `helm rollback` is unavailable. Rollback is performed by reverting Git configuration and re‑syncing application.

Clean‑up lab resources

```bash
argocd app delete helm-guestbook -y
kubectl delete ns helm-guestbook
```

</details>