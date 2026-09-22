# Step2 Apply the manifest
> Important: CRD resource size exceeds client-side apply limit, must use server-side apply flags.

Run install command:

```bash
kubectl apply -n argocd --server-side --force-conflicts -f /tmp/install.yaml
```

or you can apply official manifest. Maybe you need to fix network security issues due to the latest release, and it will be covered in subsequent courses.

```bash
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
