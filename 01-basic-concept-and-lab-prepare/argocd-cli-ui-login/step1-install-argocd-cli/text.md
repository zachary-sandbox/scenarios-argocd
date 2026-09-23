# Step1 Install argocd CLI binary
Download matching release binary from Argo-CD github releases page.
Official doc: https://argo-cd.readthedocs.io/en/stable/cli-installation/

```bash
export ARGOCD_VERSION=v3.5.3 && \
curl -fsSL --connect-timeout 10 --max-time 30 -o argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64 && \
sudo mv argocd /usr/local/bin && \
sudo chmod +x /usr/local/bin/argocd
```{{exec}}

After installation verify:
```bash
argocd version --client
```{{exec}}
