# Step3 Test prune behaviour
Prune removes cluster resources which no longer exist in git manifests.

Lab exercise concept:
1. In your git repository, remove one kubernetes manifest file (e.g a ConfigMap yaml). Commit and push change to git.
2. Argo‑CD detects git revision change, automated sync triggers.
3. Because prune=true, corresponding ConfigMap resource gets deleted inside target namespace.

> Important risk note: If prune is enabled, accidental git manifest deletion leads to live cluster resource deletion.
