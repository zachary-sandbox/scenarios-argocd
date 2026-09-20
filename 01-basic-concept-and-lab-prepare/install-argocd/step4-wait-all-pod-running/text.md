# Step4 Wait all argocd namespace pods enter Running state
Check pod list:
```bash
kubectl get pods -n argocd
```
All pods status must be Running.
