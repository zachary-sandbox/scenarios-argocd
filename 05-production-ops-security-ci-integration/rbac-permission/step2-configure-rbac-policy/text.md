# Step2 Configure RBAC policy in argocd-cm

Edit argocd-cm configmap:
```bash
kubectl edit configmap argocd-cm -n argocd
```

Add rbac entry under data section:

```yaml
data:
  rbacPolicy.csv: |
    p, role:app-readonly, applications, get, *, allow
    p, role:app-readonly, applications, sync, *, deny
    g, demo-user, role:app-readonly
```

Save configmap change. Argo-CD api-server will reload policy.

> 
> Note: In real SSO scenario, demo-user is the user name coming from OIDC identity provider.
