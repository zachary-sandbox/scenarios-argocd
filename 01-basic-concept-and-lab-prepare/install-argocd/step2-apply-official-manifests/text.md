# Step2 Apply official install manifest
> Important: CRD resource size exceeds client-side apply limit, must use server-side apply flags.

Run official install command:

```bash
kubectl apply -n argocd --server-side --force-conflicts -f /tmp/install.yaml
```

or

```bash
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
