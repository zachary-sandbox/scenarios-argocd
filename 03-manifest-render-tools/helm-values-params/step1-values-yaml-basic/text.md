# Step1 Use values.yaml

A typical values.yaml:
```yaml
replicaCount: 2
image:
  repository: nginx
  tag: 1.25
service:
  type: ClusterIP
```

Helm templates use these values:
```yaml
replicas: {{ .Values.replicaCount }}
```

You can store values files in Git and let Argo CD render them.

Thinking question:
Why put values under version control instead of keeping them only in CI/CD variables?
