# Step1 Application CRD spec main fields
## Core spec blocks
1. **spec.source**: Git repository source configuration
    - repoURL: git repository address
    - targetRevision: branch / tag / commit hash
    - path: sub‑directory path containing kubernetes manifests
2. **spec.destination**: target deployment location
    - server: target kubernetes cluster api‑server url
    - namespace: target namespace for resources to be deployed
3. **spec.syncPolicy**: sync behaviour rules
    - CreateNamespace: auto create namespace if not exist
    - automated: enable auto sync
    - prune: delete resources removed from git
    - selfHeal: revert manual cluster edits back to git desired state

## Examples: Three Methods to Create ArgoCD Application

### Method 1: kubectl apply (Declarative YAML)
application-guestbook.yaml
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook1
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook1
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
```

Command to apply:
```bash
kubectl apply -f application-guestbook.yaml -n argocd
```

### Method 2: argocd app create (Imperative CLI)
```bash
argocd app create guestbook2 --repo https://github.com/zachary-sandbox/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook2 --project default --sync-option CreateNamespace=true --auto-prune --self-heal
```

Trigger sync manually:
```bash
argocd app sync guestbook
```

### Method 3: ArgoCD Web UI
1. Open ArgoCD UI, click **NEW APP**
2. General
   - Application Name: `guestbook3`
   - Project: `default`
3. Source
   - Repository URL: `https://github.com/zachary-sandbox/argocd-example-apps.git`
   - Revision: `HEAD`
   - Path: `guestbook`
4. Destination
   - Cluster: `in-cluster`
   - Namespace: `guestbook3`
5. Sync Policy
   - Select **Automatic**, default: `Manual`
   - Checked **PRUNE RESOURCES**
   - Checked **SELF HEAL**
6. Sync Options
   - Checked `Auto-Create Namespace`
7. Click **Create**

Or you can also paste the manifest like `application-guestbook3.yaml`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook3-optional
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook3-optional
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
    automated:
      prune: true
      selfHeal: true
```

> 1. Open ArgoCD UI, click **NEW APP**
> 2. Click **EDIT AS YAML**, paste `application-guestbook3.yaml`
> 3. Click **Create**


### Verification Commands
```bash
# List applications
argocd app list

# Check app details
argocd app get guestbook
```

## Summary
1. **kubectl apply (Declarative)**: Recommended for production. The Application manifest can be stored in Git, tracked by version control. Fully GitOps native approach.
2. **argocd app create (Imperative CLI)**: Quick for lab/test environment. Creates Application directly via CLI without YAML file. Not easy to track changes.
3. **ArgoCD Web UI**: GUI manual operation for demonstration. Good for beginners to understand parameters. Not suitable for automated CI/CD workflow.

---

## Thinking question: What happens if you omit syncPolicy entirely?

<details>
<summary>Answer</summary>

If `syncPolicy` is completely removed from the Application manifest:
1. **No automatic synchronization will happen.** ArgoCD will NOT automatically sync the desired Git state into the cluster even when Git changes occur. The application will stay `OutOfSync` until you manually trigger sync.
2. `prune` and `selfHeal` are disabled by default. Orphaned resources will not be deleted automatically; manual changes made directly inside the cluster will not be reverted back to Git desired state.
3. `syncOptions` such as `CreateNamespace=true` are also unavailable. The target namespace **will not be created automatically**. You have to manually create the target namespace before syncing, otherwise sync will fail.
4. The Application CR is still valid and can be created successfully. You can run `argocd app sync guestbook` manually to perform one-time synchronization.

### Short summary (for lab submission)
Without `syncPolicy`, auto-sync is disabled. ArgoCD only compares Git desired state against live cluster state and reports sync status, but will not apply changes automatically. You must trigger sync manually. Also, automatic namespace creation, pruning and self-heal features are not active.
</details>
