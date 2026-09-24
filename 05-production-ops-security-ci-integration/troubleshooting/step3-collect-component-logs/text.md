# Step3 Collect Argo-CD component logs

Different components are responsible for different failure categories:

- argocd-api-server: login, auth, ui, api request errors
- argocd-repo-server: git clone, helm/kustomize render errors
- argocd-application-controller: reconcile, sync, status calculation errors

Collect log example:

```bash
kubectl logs -n argocd deployment/argocd-application-controller
kubectl logs -n argocd deployment/argocd-repo-server
kubectl logs -n argocd deployment/argocd-api-server
```

For persistent investigation you can redirect output into log file:

```bash
kubectl logs -n argocd deployment/argocd-repo-server > repo-server.log
```
