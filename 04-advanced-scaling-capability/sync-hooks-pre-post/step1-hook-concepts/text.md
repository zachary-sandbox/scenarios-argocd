# Step1 Understand sync hooks

Hook types:
- PreSync: runs before main sync resources
- Sync: runs alongside main resources
- PostSync: runs after main resources are synced

Hook annotation:
```yaml
annotations:
  argocd.argoproj.io/hook: PostSync
```

Optional cleanup policy:
```yaml
annotations:
  argocd.argoproj.io/hook-delete-policy: HookSucceeded
```

Common hook resources:
- Job
- Pod
- Custom resources

Reference: https://argo-cd.readthedocs.io/en/stable/user-guide/resource_hooks/
