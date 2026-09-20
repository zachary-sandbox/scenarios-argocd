# Step2 Configure source and destination in UI form
## Source section
- Repository URL: use public sample git repository, e.g official guestbook repo
- Revision: target git branch such as `main`
- Path: manifests folder path inside git repo e.g `guestbook`

## Destination section
- Cluster: select `in‑cluster` (current argo‑cd kubernetes cluster)
- Namespace: input target namespace e.g `ui‑demo‑ns` (namespace will be created automatically)

> Do NOT enable auto‑sync for this lab exercise.
