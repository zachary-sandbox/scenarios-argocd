# Step3 Create self-management Application

Create Application pointing to your Git-stored Argo CD manifests:
```bash
argocd app create argocd-self   --repo https://github.com/<your-account>/your-repo.git   --path argocd-manifests   --dest-server https://kubernetes.default.svc   --dest-namespace argocd   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Wait for sync:
```bash
argocd app wait argocd-self
```

Verify:
```bash
argocd app get argocd-self
```

Safeguards:
- Do not enable prune lightly
- Keep a backup of working manifests
- Test changes in a staging environment first
