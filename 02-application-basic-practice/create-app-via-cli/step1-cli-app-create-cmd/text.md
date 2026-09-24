# Step1 Imperative create application with argocd app create

Sample command:

```bash
argocd app create guestbook-via-cli --repo https://github.com/zachary-sandbox/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace guestbook-via-cli --project default --sync-option CreateNamespace=true --auto-prune --self-heal
```

After executing command, list all applications:

```bash
argocd app list
```

> **argocd app create (Imperative CLI)**: Quick for lab/test environment. Creates Application directly via CLI without YAML file, but not easy to track changes.

