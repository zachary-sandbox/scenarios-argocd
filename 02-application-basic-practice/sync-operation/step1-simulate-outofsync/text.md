# Step1 Simulate OutOfSync condition
Pick one deployment managed by your argo‑cd application. Imperatively edit replica count directly on cluster:
```bash
kubectl edit deployment -n cli‑demo‑ns guestbook‑ui
```
Change replicas number to different value, save and exit editor.

Now Argo‑CD detects live cluster diverges from git stored manifest, Application status becomes OutOfSync.

Check status:
```bash
argocd app get cli‑demo‑app
```
