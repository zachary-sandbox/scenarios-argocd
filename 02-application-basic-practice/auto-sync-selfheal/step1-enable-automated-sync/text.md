# Step1 Enable automated sync policy

Create your application CR:
application-guestbook.yaml

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

```bash
kubectl apply -f application-guestbook.yaml
```

Patch existing application to add automated syncPolicy:

```bash
kubectl patch application guestbook -n argocd --type merge -p '
{
  "spec": {
    "syncPolicy": {
      "automated": {
        "prune": true,
        "selfHeal": true
      }
    }
  }
}'
```

Inspect updated spec:

```bash
kubectl get application guestbook -n argocd -o yaml
```

>
> Warning: Once enabled, Argo‑CD will autonomously change your cluster resources without manual click.

## Thinking: What is the difference between `prune` and `selfHeal` inside automated sync?

<details>
<summary>Answer</summary>

- **prune**: When set to `true`, ArgoCD deletes cluster resources that exist in live cluster but no longer appear in Git manifests (orphaned resources). If you remove a resource from Git, ArgoCD automatically deletes it from Kubernetes. When `prune: false`, those orphaned resources will stay in cluster and application becomes OutOfSync.
- **selfHeal**: When set to `true`, ArgoCD reverts manual in‑cluster edits back to Git desired state. If someone modifies resources directly inside Kubernetes (bypassing Git), ArgoCD will overwrite those live changes to match Git. If `selfHeal: false`, manual cluster modifications persist and the application shows OutOfSync status, but no auto‑revert happens.

### Short summary (lab submission)

`prune` removes resources deleted from Git. 

`selfHeal` reverts manual live‑cluster modifications back to Git desired manifests. Both only take effect when automated sync is enabled.

</details>