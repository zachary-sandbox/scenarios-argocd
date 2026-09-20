# Step3 Image override and patches

Edit your overlay kustomization.yaml to add an image override:
```yaml
images:
  - name: gcr.io/heptio-images/ks-guestbook-demo
    newTag: 0.2
```

Or add a patch to change replicas:
```yaml
patches:
  - target:
      kind: Deployment
      name: guestbook
    patch: |
      spec:
        replicas: 3
```

Commit and push to Git, then verify Argo CD reconciles the change.

Check the deployment:
```bash
kubectl get deployment -n kustomize-demo
```
