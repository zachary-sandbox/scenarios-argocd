# Step2 Configure private Helm repository

Add a private Helm repository:

```text
export YOUR_HELM_CHART=oci://registry-1.docker.io/zachary404/helm-guestbook
export YOUR_CHART_VERSION=0.1.0
export YOUR_DOCKER_USERNAME=zachary404
export YOUR_DOCKER_TOKEN=dckr_pat_57sOEA...
```


```bash
helm pull ${YOUR_HELM_CHART} --version ${YOUR_CHART_VERSION}
```

```bash
argocd repo add ${YOUR_HELM_CHART} \
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
