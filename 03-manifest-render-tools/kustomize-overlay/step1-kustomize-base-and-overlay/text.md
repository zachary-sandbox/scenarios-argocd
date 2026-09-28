# Step1 Understand Kustomize base and overlay

e.g. `~/k8s`, a typical Kustomize layout:

```
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

The **base** contains common, shared core resources (Deployment, Service etc).
The **overlay** adds environment-specific changes such as:

- namespace
- replicas count
- resource limits & requests
- environment variables
- strategic-merge / json6902 patches

Render an overlay locally on workstation:

```bash
kubectl kustomize overlays/dev
```

```bash
kubectl kustomize overlays/prod
```