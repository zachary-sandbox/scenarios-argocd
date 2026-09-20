# Step3 Argo‑CD official upgrade procedure

1. Read release notes of target new version, check breaking‑changes.
2. Backup: backup argocd namespace resources, configmaps, secrets.
3. Download new version install.yaml manifest.
4. Apply manifest with server‑side apply:

```bash
kubectl apply -n argocd --server‑side --force‑conflicts -f new‑install.yaml
```

5. Wait all deployment rollout complete:

```bash
kubectl rollout status deployment -n argocd
```

6. Verify all pods Running, argocd version, application status normal.

> 
> Important: Never skip reading release notes before production upgrade.
