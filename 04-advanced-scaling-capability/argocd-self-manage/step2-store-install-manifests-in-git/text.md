# Step2 Store Argo CD manifests in Git

Download official install manifests:
```bash
curl -o argocd-install.yaml https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Split or organize them into a Git repository directory:
```text
argocd-manifests/
├── namespace.yaml
├── service-account.yaml
├── cluster-role.yaml
└── install.yaml
```

Commit and push to Git.

Important:
Treat this repository carefully.
It contains the definition of your Argo CD control plane.
