# Step3 Deploy Application to remote cluster

Create namespace on remote cluster first if needed.

Create Application pointing to remote cluster:
```bash
argocd app create remote-app   --repo https://github.com/argoproj/argocd-example-apps.git   --path plain   --dest-server https://<remote-cluster-api-server>   --dest-namespace remote-demo-ns   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for sync:
```bash
argocd app wait remote-app
```

Check resources on remote cluster:
```bash
kubectl get all -n remote-demo-ns --context <remote-kubeconfig-context>
```
