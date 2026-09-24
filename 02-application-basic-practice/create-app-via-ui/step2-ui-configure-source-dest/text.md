# Step2 Configure source and destination in UI form
## Source section
- Repository URL: use public sample git repository, e.g. `https://github.com/zachary-sandbox/argocd-example-apps.git`
- Revision: target git branch such as `HEAD`
- Path: manifests folder path inside git repo e.g. `guestbook`

## Destination section
- Cluster: select `in‑cluster` (current argo‑cd kubernetes cluster)
- Namespace: input target namespace e.g. `guestbook-via-ui` (namespace will be created automatically)

> Do NOT enable auto‑sync for this lab exercise.
