# Step3 Multiple values files

Organize values files by environment:
```text
helm/
├── values.yaml
├── values-dev.yaml
└── values-prod.yaml
```

In Argo CD, specify additional values files:
```yaml
spec:
  source:
    helm:
      valueFiles:
        - values.yaml
        - values-dev.yaml
```

Values files are merged in order.
Later files override earlier ones.

Thinking question:
What are the advantages of separating dev and prod values files?
