# Step1 Install kind tool
Kind is a tool for running local Kubernetes clusters using Docker container “nodes”.

Official installation guide: https://kind.sigs.k8s.io/docs/user/quick-start/#installation

## Installing From Release Binaries
```bash
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.33.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

## Verify installation after finished:
```bash
kind version
```
Confirm command outputs valid version string.
