# Step1 Argo-CD metrics overview

Key metrics:

- argocd_app_sync_status: Gauge, sync status code (0 Synced / 1 OutOfSync)
- argocd_app_health_status: Gauge, application health status
- argocd_repo_server_requests_total: repo-server request counter
- argocd_controller_reconciliation_duration_seconds: reconciliation latency histogram

Each component exposes its own /metrics endpoint:

- argocd-api-server
- argocd-application-controller
- argocd-repo-server

These metrics are used to build dashboards and trigger prometheus alerts for OutOfSync applications.
