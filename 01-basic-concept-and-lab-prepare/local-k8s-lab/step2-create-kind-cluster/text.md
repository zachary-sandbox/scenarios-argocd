# Step2 Create kind cluster argocd-lab
Run command:
```bash
kind create cluster --name argocd-lab
```

After creation completes, check current kubectl context:
```bash
kubectl config current-context
```
Context name should contain `argocd-lab`.
