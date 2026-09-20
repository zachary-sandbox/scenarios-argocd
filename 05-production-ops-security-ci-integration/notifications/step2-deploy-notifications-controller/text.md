# Step2 Install argo‑notifications controller

Official install manifest:

```bash
kubectl apply -n argocd -f [https://raw.githubusercontent.com/argoproj/argo](https://raw.githubusercontent.com/argoproj/argo)‑cd/stable/manifests/notifications/install.yaml
```

Wait pod ready:

```bash
kubectl get pods -n argocd | grep notifications
```

Check deployment exists:

```bash
kubectl get deployment argocd‑notifications‑controller -n argocd
```
