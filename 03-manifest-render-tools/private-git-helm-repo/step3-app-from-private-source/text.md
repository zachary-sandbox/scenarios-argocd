# Step3 Create Application from private source

Once credentials are configured, create an Application from the private source:
```bash
argocd app create private-app   --repo https://github.com/your-org/your-private-repo.git   --path manifests   --dest-server https://kubernetes.default.svc   --dest-namespace private-demo-ns   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for sync:
```bash
argocd app wait private-app
```

Troubleshooting tips:
- Check repo-server logs for authentication failures
- Verify credential secret exists in argocd namespace
- Confirm network access to the private repository
