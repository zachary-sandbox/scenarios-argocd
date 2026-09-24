# Step3 Validate permission

If you configure SSO login with demo-user:

1. Login Web UI as demo-user
2. Try to view applications (get action should allowed)
3. Try trigger sync / delete application (should be denied)

CLI test idea (if token for demo-user obtained):

```bash
argocd app list --auth-token <demo-user-token>
```

Best practice:

- Avoid grant global admin permission for regular users
- Restrict scope to project/application as much as possible.
