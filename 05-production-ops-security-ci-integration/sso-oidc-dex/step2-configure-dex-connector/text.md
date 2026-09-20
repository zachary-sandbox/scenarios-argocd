# Step2 Configure Dex connector

Edit dex configmap:

```bash
kubectl edit configmap argocd-dex-config -n argocd
```

Add connector fragment example for GitHub:

```
connectors:
- type: github
  id: github
  name: GitHub
  config:
    clientID: xxx-client-id
    clientSecret: xxx-client-secret
    orgs:
    - name: my‑org
```

After configmap changed, restart dex pod to reload configuration:

```bash
kubectl rollout restart deployment argocd‑dex -n argocd
```

> 
> Production note: clientSecret should use Kubernetes Secret instead of plain configmap.
