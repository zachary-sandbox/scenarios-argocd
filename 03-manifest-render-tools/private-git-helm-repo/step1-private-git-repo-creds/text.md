# Step1 Configure private Git repository credentials

Create a Kubernetes Secret for Git credentials:
```bash
kubectl create secret generic private-git-creds   -n argocd   --from-literal=username=your-git-username   --from-literal=password=your-git-token
```

Register the repository in Argo CD:
```bash
argocd repo add https://github.com/your-org/your-private-repo.git   --username your-git-username   --password your-git-token   --insecure-skip-server-verification=false
```

Verify:
```bash
argocd repo list
```
