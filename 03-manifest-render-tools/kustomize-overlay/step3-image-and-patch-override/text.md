# Step3 Image override and patches

Edit your overlay kustomization.yaml to add an image override:
```yaml
images:
  - name: nginx
    newTag: "1.26"
```

Or add a patch to change replicas:
```yaml
patches:
  - target:
      kind: Deployment
      name: guestbook-ui
    patch: |
      spec:
        replicas: 5
```

Commit and push to Git, then verify Argo CD reconciles the change.

Check the deployment:
```bash
kubectl get deployment -n kustomize-demo
```

## Thinking: In Kustomize base-overlay pattern, what is the purpose of `base` and `overlay` respectively? And which directory should ArgoCD `spec.source.path` point to?


<details>
<summary>Answer</summary>

`base` stores shared common Kubernetes manifests which are reused across multiple environments.
`overlay` inherits from base and applies environment-specific customizations (namespace, replica count, patches, resources). It does not duplicate full copies of base resources.

For ArgoCD Application, `spec.source.path` should point to **overlay directory** (for example `k8s/overlays/prod`), not base folder. ArgoCD executes kustomize-build against overlay to produce final manifests.

### Short summary (lab submission)

Base holds shared common resources. Overlays apply env-specific customizations without duplicating base manifests. ArgoCD path points to overlay directory.

</details>

## Thinking: What advantage does Kustomize base-overlay bring, compared to maintaining complete separate copies of YAML for dev / prod?

<details>
<summary>Answer</summary>

If maintaining full separate YAML copies for each environment, you duplicate entire manifest files. Bug-fix or feature changes must be manually updated in every environment copy, which brings high maintenance overhead and risk of inconsistency.

With base-overlay pattern: core manifests live once in base. Each overlay only contains delta / patch changes for its environment. One fix in base automatically applies to all overlays. Only environment-unique settings stay inside overlay.

### Short summary (lab submission)

Base-overlay avoids full YAML duplication. Shared resources are maintained once in base; overlays only contain environment-specific deltas. Reduces maintenance work and configuration drift risk.

</details>

## Clean-up lab resources

```
argocd app delete kustomize-demo -y
kubectl delete ns prod
```