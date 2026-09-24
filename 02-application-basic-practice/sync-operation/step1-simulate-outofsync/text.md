# Step1 Simulate OutOfSync condition

Fork https://github.com/zachary-sandbox/argocd-example-apps.git to your git repository. 

Sample command:

```bash
export YOUR_REPO_NAME=zachary-sandbox
argocd app create guestbook-via-cli --repo https://github.com/$YOUR_REPO_NAME/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook-via-cli --project default --sync-option CreateNamespace=true --auto-prune --self-heal
```

Pick one deployment managed by your argo‑cd application. Imperatively edit replica count directly on cluster:
```bash
kubectl edit deployment -n guestbook-via-cli guestbook‑ui
```
Change replicas number to different value, save and exit editor.

Now Argo‑CD detects live cluster diverges from git stored manifest, Application status becomes OutOfSync.

Check status:
```bash
argocd app get guestbook-via-cli
```
