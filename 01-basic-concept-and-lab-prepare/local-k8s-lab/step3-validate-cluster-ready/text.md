# Step3 Validate cluster node ready status
Inspect node status:
```bash
kubectl get nodes
```
Expected output: node status should show `Ready`.

Inspect pod status:
```bash
kubectl get pod -A
```
Expected output: pod status should show `Running`.
