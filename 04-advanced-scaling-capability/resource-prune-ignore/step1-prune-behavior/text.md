# Step1 Understand prune behavior

Prune behavior:
- If a resource is removed from Git, Argo CD can delete it from the cluster.
- Prune requires `syncPolicy.automated.prune: true` or manual sync with prune option.

Risk:
- Accidental deletion of Git files can delete live resources.

Thinking question:
When should you enable prune in production?
