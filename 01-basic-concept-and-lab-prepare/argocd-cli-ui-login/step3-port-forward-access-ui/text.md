# Step3 Port-forward for Web-UI local access
Run port-forward command in separate terminal window:
```bash
kubectl port-forward svc/argocd-server -n argocd 30080:80
```

Open browser and navigate to:
[Argo CD Web-UI]({{TRAFFIC_HOST1_30080}})

Login username: admin
Password: decoded value obtained in step2.
