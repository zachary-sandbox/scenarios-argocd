# Step1 Notifications core concept

Three core building blocks:

1. **Trigger**: define which Argo‑CD event will fire notification.
Examples: on‑sync‑status‑changed, on‑health‑status‑changed.
2. **Template**: define notification message content, support variables interpolation from Application resource.
3. **Service**: define where notification get delivered: webhook, slack, email.

Workflow:
Application event → trigger matched → render message with template → send to service endpoint.
