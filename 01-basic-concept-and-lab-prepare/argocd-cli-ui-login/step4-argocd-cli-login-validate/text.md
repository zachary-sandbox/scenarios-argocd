# Step4 argocd cli login and connectivity test
Execute login command:
```bash
argocd login 127.0.0.1:8080 --insecure
```
Input username admin and initial password.

After login complete, run:
```bash
argocd version
```
Should print both client version and server version information without errors.
