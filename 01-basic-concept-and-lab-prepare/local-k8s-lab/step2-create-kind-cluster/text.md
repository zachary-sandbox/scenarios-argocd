# Step2 Create kind cluster argocd-lab

```bash
kind create cluster --name argocd-lab --image kindest/node:v1.37.0
```

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

After creation completes, check current kubectl context:
```bash
kubectl config current-context
```

Context name should contain `argocd-lab`.
