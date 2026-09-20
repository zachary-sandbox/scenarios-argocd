# Step1 Understand Kustomize base and overlay

A typical Kustomize layout:
```text
k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── overlays/
    ├── dev/
    │   └── kustomization.yaml
    └── prod/
        └── kustomization.yaml
```

The base contains common resources.
The overlay adds environment-specific changes such as:
- namespace
- replicas
- resource limits
- env variables
- patches

Render an overlay locally:
```bash
kubectl kustomize overlays/dev
```
