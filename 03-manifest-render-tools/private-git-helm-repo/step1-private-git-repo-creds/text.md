# Step1 Configure private Git repository credentials

ArgoCD needs credentials to access private git repository. Two approaches:

1. Use `argocd repo add`: register repo directly to ArgoCD (credentials stored inside ArgoCD internal storage).
2. Create Kubernetes Secret of type `argoproj.io/git-creds`: declarative way, ArgoCD automatically picks up this secret.

>
> Note: For GitHub/GitLab, use **personal access token(PAT)** as password, do not use original account password.

Update to your private Git repository:

```text
export YOUR_REPO_FORKED=https://github.com/zachary-sandbox/charts.git
export YOUR_GIT_USERNAME=zachary404
export YOUR_GIT_TOKEN=github_pat_11A3YT...
```

Create a Kubernetes Secret for Git credentials (declarative approach):

```bash
kubectl create secret generic private-git-creds \
  -n argocd \
  --from-literal=username=${YOUR_GIT_USERNAME} \
  --from-literal=password=${YOUR_GIT_TOKEN}
```

Label secret so ArgoCD can discover this git credential secret:

```bash
kubectl label secret private-git-creds -n argocd argocd.io/repository-credential=true
```

Register the repository in ArgoCD via CLI (imperative approach):

```bash
argocd repo add ${YOUR_REPO_FORKED} \
  --username ${YOUR_GIT_USERNAME} \
  --password ${YOUR_GIT_TOKEN} \
  --insecure-skip-server-verification=false
```

Verify repository status:

```
argocd repo list
```

> Important difference

- `argocd repo add`: Imperative command, credentials saved inside ArgoCD's internal secret storage. If ArgoCD pod redeploy, repo config still persists.
- Labeled k8s Secret (`argoproj.io/git-creds`): Declarative GitOps style, you can store this secret manifest in your repository (secret value should be sealed‑secret, never plain text). ArgoCD auto‑discovers credentials.

Example declarative git credential Secret YAML:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-git-creds
  namespace: argocd
  labels:
    argocd.io/repository-credential: "true"
type: Opaque
data:
  username: <base64‑encoded‑username>
  password: <base64‑encoded‑git‑token>
```

Lab steps

1. Use PAT token for password value.
2. Run `argocd repo list`, check repo connection status is `Successful`.
3. Create ArgoCD Application pointing to private git repo URL.

Example Application using private git repo:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: private-repo-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/charts.git
    targetRevision: HEAD
    path: bitnami/nginx
  destination:
    server: https://kubernetes.default.svc
    namespace: demo
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

Observation:
If credential wrong or missing, repository status shows `Failed`, ArgoCD Application will report `repository not accessible` error.

## Thinking: For GitHub private repository, what value should you supply for password field?

<details>
<summary>Answer</summary>

You should use Personal Access Token(PAT), not your original account login password.

</details>

## Thinking: What happens if ArgoCD cannot get valid private git credentials?

<details>
<summary>Answer</summary>

ArgoCD marks repository status as failed. Application will report `repository not accessible` error, cannot read manifests from git, sync will not work.

</details>

## Clean‑up lab

```
argocd repo rm ${YOUR_REPO_FORKED} -y
kubectl delete secret private-git-creds -n argocd
```
