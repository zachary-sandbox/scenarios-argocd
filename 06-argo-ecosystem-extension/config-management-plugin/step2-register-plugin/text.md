# Step2 Register custom sidecar config-management-plugin

Main steps for sidecar CMP:
1. Build custom plugin container image, contains your render binary / script.
2. Patch argocd-repo-server deployment, add your plugin as additional sidecar container.
3. Configure argocd-cm to declare plugin identifier.
4. Rollout restart repo-server deployment.

Example argocd-cm snippet for registering plugin:
```yaml
data:
  configManagementPlugins: |
    - name: my-custom-render-plugin
```

Patch repo-server deployment to inject sidecar:
```bash
kubectl edit deployment argocd-repo-server -n argocd
# add sidecar container volume mounts for plugin binary
```

Restart repo-server:
```bash
kubectl rollout restart deployment argocd-repo-server -n argocd
```
