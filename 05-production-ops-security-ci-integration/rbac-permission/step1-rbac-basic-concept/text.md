# Step1 RBAC basic concept

Argo‑CD RBAC main elements:
- **p (policy)**: define permission rule for subject
- **g (group)**: assign user to group
- Subject: user / group name
- Resource: applications, projects, repositories, clusters
- Action: get, create, update, delete, sync
- Object: filter target object name, use  for all

Example policy snippet:
```

p, role:readonly, applications, get, *, allow
p, role:readonly, applications, sync, *, deny

```

Difference between Kubernetes RBAC and Argo‑CD RBAC:
- K8s RBAC controls access to kubernetes api resources.
- Argo‑CD RBAC controls Argo‑CD application/project/repository inside argocd control plane.
