# Step2 Install Argo Rollouts controller

Apply official installation manifest:
```bash
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f [https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml](https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml)
```

Wait for rollouts controller pod ready:
```bash
kubectl get pods -n argo-rollouts
```

Install argo‑rollouts kubectl plugin for cli observation:
```bash
brew install argo‑rollouts-plugin
# or download binary from github release page
```

Verify plugin:
```bash
kubectl argo rollouts --help
```
