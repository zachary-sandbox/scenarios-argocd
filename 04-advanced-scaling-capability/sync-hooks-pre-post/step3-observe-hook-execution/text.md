# Step3 Observe hook execution

Create an Application that includes the hook Job and a plain resource.

Example structure:
```text
hooks-demo/
├── configmap.yaml
└── post-sync-job.yaml
```

Create Application:
```bash
argocd app create hooks-app   --repo https://github.com/<your-account>/your-repo.git   --path hooks-demo   --dest-server https://kubernetes.default.svc   --dest-namespace hooks-demo   --project default   --sync-policy automated --sync-policy prune=true --sync-policy self-heal=true
```

Watch Application sync:
```bash
argocd app get hooks-app
```

Check Job logs:
```bash
kubectl logs -n hooks-demo job/post-sync-job
```
