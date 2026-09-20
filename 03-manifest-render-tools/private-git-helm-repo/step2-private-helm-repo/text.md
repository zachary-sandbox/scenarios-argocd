# Step2 Configure private Helm repository

Add a private Helm repository:
```bash
argocd repo add https://your-private-helm-repo.example.com/charts   --type helm   --name private-helm-repo   --username your-helm-username   --password your-helm-password
```

Verify the repository is recognized:
```bash
argocd repo list
```

Important:
Repository credentials should be treated as sensitive data.
Prefer secret-based credential management in production.
