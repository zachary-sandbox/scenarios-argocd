## Step2 Configure Helm values inside ArgoCD Application CR

Two common ways to supply custom Helm values for ArgoCD:

ArgoCD provides three ways to supply Helm custom values for chart rendering:

1. `valueFiles`: Reference external `values.yaml` file stored in Git repository
2. `values`: In-line multi-line YAML string inside Application manifest (uses `|` pipe literal block)
3. `valuesObject`: Native structured YAML/JSON object inside Application manifest, no pipe symbol required

Precedence from lowest to highest:
`valueFiles` → `values` → `valuesObject`

> Higher precedence configuration will overwrite conflicting keys from lower-precedence sources.

YAML example showing all three:

```yaml
spec:
  source:
    helm:
      # 1. valueFiles: load external yaml file from Git repo
      valueFiles:
        - values-common.yaml

      # 2. values: multi-line text block with | pipe
      values: |
        replicaCount: 1
        service:
          type: ClusterIP

      # 3. valuesObject: native nested object, NO pipe |
      valuesObject:
        replicaCount: 2
        service:
          type: NodePort
```