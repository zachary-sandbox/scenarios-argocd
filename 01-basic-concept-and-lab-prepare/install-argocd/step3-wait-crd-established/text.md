# Step3 Wait for Argo-CD CRD established
Check Application CRD exists:
```bash
kubectl get crd applications.argoproj.io
```
Condition: AGE column shows valid age value, status Established=True.
