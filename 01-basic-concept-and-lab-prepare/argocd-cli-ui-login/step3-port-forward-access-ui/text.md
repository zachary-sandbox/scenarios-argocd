# Step3 Port-forward for Web-UI local access
Run port-forward command in separate terminal window:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open browser and navigate to:
https://127.0.0.1:8080

Login username: admin
Password: decoded value obtained in step2.
Accept browser self-signed certificate warning.
