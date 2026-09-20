# Step2 Register remote cluster

If you have a second cluster, add it to Argo CD:
```bash
argocd cluster add <remote-kubeconfig-context> --name remote-cluster
```

List registered clusters:
```bash
argocd cluster list
```

Verify the cluster secret:
```bash
kubectl get secret -n argocd | grep cluster
```
