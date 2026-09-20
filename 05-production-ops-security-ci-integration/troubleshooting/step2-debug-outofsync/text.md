# Step2 Debug OutOfSync status

Two ways to see difference between Git desired and live cluster state:

1. Web UI: enter application → select resource → DIFF tab to view yaml difference.
2. CLI command argocd app diff:
```bash
argocd app diff <app‑name>
```

Common OutOfSync reasons:

1. Manual kubectl edit modified live resources without selfHeal=true
2. Controller reconciliation delay
3. Some controller‑managed fields mutated inside cluster

When you see diff output, you know exactly which field diverged.
