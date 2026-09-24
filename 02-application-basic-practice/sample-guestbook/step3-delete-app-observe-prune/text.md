# Step3 Delete Application CR and observe resource cleanup behaviour

Delete Argo‑CD Application custom‑resource:
```bash
argocd app delete guestbook-via-cli
```

> Important default behaviour:
By default deleting Application CR **does NOT delete the managed guestbook kubernetes resources (pod/deployment/service)**.
Only the Application CR object itself gets removed.

If you want cascade deletion of managed resources when deleting Application:
You need to add finalizer: `resources-finalizer.argocd.argoproj.io` on Application metadata.

Reference doc: https://argo-cd.readthedocs.io/en/stable/user-guide/app_deletion/
