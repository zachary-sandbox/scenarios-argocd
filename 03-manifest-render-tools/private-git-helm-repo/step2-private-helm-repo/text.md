# Step2 Configure private Helm repository

Add a private Helm repository:

```bash 
export YOUR_HELM_CHART=oci://registry-1.docker.io/zachary404/helm-guestbook
export YOUR_CHART_VERSION=0.1.0
export YOUR_DOCKER_USERNAME=zachary404
export YOUR_DOCKER_TOKEN=dckr_pat_57sOEA...

argocd repo add  registry-1.docker.io \
  --type helm --name stable --enable-oci \
  --username ${YOUR_DOCKER_USERNAME} \
  --password ${YOUR_DOCKER_TOKEN}
```

Verify the repository is recognized:
```bash
argocd repo list
```

Important:
Repository credentials should be treated as sensitive data.
Prefer secret-based credential management in production.
