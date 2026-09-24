# Step3 Allow controlled drift with ignoreDifferences

`ignoreDifferences` lets Argo-CD ignore certain field differences between Git desired manifest and live cluster resource. It allows **controlled drift**: those field changes in-cluster will NOT cause `OutOfSync` status.

>
> Important note:
> By default `ignoreDifferences` only affects **diff calculation (sync status)**. Without `RespectIgnoreDifferences=true`, sync operation will still overwrite those ignored fields. Add `RespectIgnoreDifferences=true` in syncOptions to preserve live-cluster values during sync.

Partial Application CR snippet (ignore Deployment `spec.replicas`):

```
spec:
  ignoreDifferences:
  - group: apps
    kind: Deployment
    jsonPointers:
    - /spec/replicas
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
      - RespectIgnoreDifferences=true
    automated:
      prune: true
      selfHeal: true
```

## Lab experimental steps

1. Patch existing guestbook Application to add `ignoreDifferences` rule:

```
kubectl patch application guestbook -n argocd --type merge -p '
{
  "spec": {
    "ignoreDifferences": [
      {
        "group":"apps",
        "kind":"Deployment",
        "jsonPointers":["/spec/replicas"]
      }
    ],
    "syncPolicy": {
      "syncOptions": [
        "CreateNamespace=true",
        "RespectIgnoreDifferences=true"
      ],
      "automated": {
        "prune":true,
        "selfHeal":true
      }
    }
  }
}'
```

2. Manually scale deployment inside cluster:

```
kubectl scale deployment guestbook-ui -n guestbook --replicas=5
```

3. Observe application status:

```
argocd app list guestbook
kubectl get deployment -n guestbook guestbook-ui
```

Observation:

- Replicas stays `5` in cluster, **not reverted by selfHeal**.
- Application status stays `Synced`, no `OutOfSync` even though replica value differs from Git.

4. Clean-up experiment (remove ignoreDifferences):

```
kubectl patch application guestbook -n argocd --type merge -p '{"spec":{"ignoreDifferences":null}}'
```

## Thinking: What happens if you set `ignoreDifferences` but forget `RespectIgnoreDifferences=true`?

<details>
<summary>Answer</summary>

1. `ignoreDifferences` still affects diff calculation: ArgoCD ignores the field difference for status check, so application shows `Synced` even when live value diverges from Git.
2. However during sync operation, ArgoCD applies full Git manifest and **overwrites the ignored field back to Git value**. The live-cluster manual change gets reverted.
3. Common pitfall: Application looks `Synced` in UI, but sync action still resets your manually-modified field.

### Short summary (lab submission)

Without `RespectIgnoreDifferences=true`, `ignoreDifferences` only suppresses `OutOfSync` status. Sync will still overwrite those fields from Git. To preserve drifted field values during sync, you must enable `RespectIgnoreDifferences=true`.

Reference doc: [https://argo-cd.readthedocs.io/en/stable/user-guide/diffing/](https://argo-cd.readthedocs.io/en/stable/user-guide/diffing/)

</details>