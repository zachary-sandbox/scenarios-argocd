# Step3 Canary and Blue-Green practice

Create lab namespace:
```bash
kubectl create namespace rollouts-demo
```

Sample minimal canary rollout yaml snippet:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: canary-demo
  namespace: rollouts-demo
spec:
  replicas: 4
  selector:
    matchLabels:
      app: canary-demo
  template:
    metadata:
      labels:
        app: canary-demo
    spec:
      containers:
      - name: demo
        image: nginx:1.24
        ports:
        - containerPort: 80
  strategy:
    canary:
      steps:
      - setWeight: 25
      - pause: {duration: 30s}
      - setWeight: 50
      - pause: {duration: 30s}
      - setWeight: 100
```

Apply manifest:
```bash
kubectl apply -f rollout-canary.yaml
```

Observe rollout progress with plugin:
```bash
kubectl argo rollouts get rollout canary-demo -n rollouts-demo
```

Modify image tag to trigger canary progressive rollout.
Similarly test blue-green strategy by changing spec.strategy to blueGreen.
