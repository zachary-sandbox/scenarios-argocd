# Step3 Configure trigger template and webhook receiver

Modify argocd‑notifications‑cm configmap:
- Define template: webhook payload content
- Define trigger: bind event to template
- Define service: webhook url endpoint

Minimal example:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
  namespace: argocd
data:
  template.app-status-changed: |
    message: Application {{.app.metadata.name}} status changed.
  trigger.on-sync-status-changed: |
    - when: app.status.syncStatus != ''
      send: [app-status-changed]
  service.webhook.demo-webhook: |
    url: [https://webhook.site/xxxxxxx](https://webhook.site/xxxxxxx)
```

After configmap update, change application sync status to trigger notification.
Check notifications controller pod logs for send result.
