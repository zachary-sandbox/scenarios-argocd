# Step2 Retrieve admin initial password
Extract base64 encoded password from secret and decode:
```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```
Save printed password value for next login steps.
