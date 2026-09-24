# Step1 Debug repo-server issues

Repo-server common failures:

1. Git repository credential wrong → cannot clone repo
2. Network policy block outbound git access
3. Helm / Kustomize template render error

View repo-server logs:

```bash
kubectl logs -n argocd deployment/argocd-repo-server
```

You can use argocd repo verify command to test repository connectivity:

```bash
argocd repo list
argocd repo verify <repo-url>
```
