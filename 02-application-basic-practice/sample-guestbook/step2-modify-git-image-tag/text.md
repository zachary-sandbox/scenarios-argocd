# Step2 Modify container image tag inside Git manifest
> For lab purpose you can fork the example git repository to your own account to make commits.

1. Edit deployment manifest inside git repo, change container image tag value.
2. Git commit and push the modification.
3. Argo‑CD repo‑server periodically fetches git, detects revision change.
4. Automated sync triggers, kubernetes performs rolling update for guestbook pods.

Watch pod status change:
```bash
kubectl get pods -n guestbook‑ns -w
```

This demonstrates core GitOps workflow: **all changes originate from Git repository**.
