# Step2 Create hook Job

Create namespace:
```bash
kubectl create namespace hooks-demo
```

Create a file post-sync-job.yaml:
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: post-sync-job
  namespace: hooks-demo
  annotations:
    argocd.argoproj.io/hook: PostSync
    argocd.argoproj.io/hook-delete-policy: HookSucceeded
spec:
  template:
    spec:
      containers:
        - name: post-sync
          image: busybox
          command: [echo, PostSync
