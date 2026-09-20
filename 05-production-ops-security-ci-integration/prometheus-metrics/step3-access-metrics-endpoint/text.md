# Step3 Access /metrics endpoint

Open port‑forward for argocd‑api‑server service in separate terminal:
```bash
kubectl port‑forward svc/argocd-api-server -n argocd 8081:8080
```

Fetch raw metrics output:

```
curl [http://127.0.0.1:8081/metrics](http://127.0.0.1:8081/metrics)
```

Filter application sync related metrics:

```
curl [http://127.0.0.1:8081/metrics](http://127.0.0.1:8081/metrics) | grep argocd_app_
```

You can configure Prometheus Operator ServiceMonitor to automatically scrape these endpoints in production cluster.
