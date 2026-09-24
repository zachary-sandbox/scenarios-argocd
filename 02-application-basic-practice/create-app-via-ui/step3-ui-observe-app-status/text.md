# Step3 Create application and observe status
Click **CREATE** button on UI form.

Now application appears in application list.
Observe status badge: you will see **OutOfSync**.
Because we have not triggered sync action yet, git desired manifests have not been applied to cluster.

Verify Application CR exists via kubectl:
```bash
kubectl get application guestbook-via-ui -n argocd
```
