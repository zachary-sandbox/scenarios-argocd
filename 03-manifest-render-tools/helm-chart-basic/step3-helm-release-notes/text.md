# Step3 Review Helm release behavior

After sync, check deployed resources:
```bash
kubectl get all -n helm-basic-demo
```

Consider these points:
1. Each Argo CD Application corresponds to one logical Helm release.
2. Changes in values or chart version will generate new rendered manifests.
3. Argo CD manages the lifecycle of the rendered Kubernetes resources.

Thinking question:
Why is Helm rendering useful compared to maintaining plain YAML for every environment?
