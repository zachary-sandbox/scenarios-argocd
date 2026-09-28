# Step2 Configure private Helm repository

Add a private Helm repository:
```bash
argocd repo add https://zachary-sandbox.github.io/charts/bitnami   --type helm   --name private-helm-repo   --username your-helm-username   --password your-helm-password
```

```bash
argocd repo add https://zachary-sandbox.github.io/charts/bitnami \
  --username ${YOUR_GIT_USERNAME} \
  --password ${YOUR_GIT_TOKEN} \
  --insecure-skip-server-verification=false
```

Verify the repository is recognized:
```bash
argocd repo list
```

Important:
Repository credentials should be treated as sensitive data.
Prefer secret-based credential management in production.
