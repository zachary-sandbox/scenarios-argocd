# Step1 HA architecture overview

Default install:

- Most deployments run single pod replica, for lab / dev environment.

HA production requirements:

1. argocd‑api‑server: multiple replicas
2. argocd‑repo‑server: multiple replicas stateless
3. argocd‑application‑controller: multiple replicas (leader election built‑in)
4. redis‑ha: redis + sentinel for high‑availability cache

> 
> application‑controller uses kubernetes leader election, only one replica actively reconcile resources at one time.
