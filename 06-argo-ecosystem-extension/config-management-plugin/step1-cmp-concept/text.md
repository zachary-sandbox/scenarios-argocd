# Step1 Config‑Management‑Plugin concept

Argo‑CD repo‑server built‑in renderers: plain yaml, Kustomize, Helm, Jsonnet.

When you need other custom templating / preprocessing tool (your own cli tool), use **Config‑Management‑Plugin(CMP)**.

Working flow:
1. Repo‑server clone Git repository.
2. Detect Application uses custom plugin.
3. Spawn plugin executable inside repo‑server container.
4. Plugin reads source files, outputs raw Kubernetes YAML manifests to stdout.
5. Repo‑server takes stdout output and passes manifest to application‑controller for reconciliation.

Two plugin modes: Sidecar plugin (recommended modern mode), legacy configmap plugin.
