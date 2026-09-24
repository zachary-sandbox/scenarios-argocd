# Step2 Test selfHeal behaviour
Again manually modify deployment replica count on cluster:
```bash
kubectl scale deployment -n guestbook guestbook-ui --replicas=3
```

Observe replicas value: after short reconciliation interval, Argo-CD self-heal will revert replicas back to git manifest defined value.

Check deployment replica status repeatedly:
```bash
kubectl get deployment -n guestbook guestbook-ui
```

> selfHeal protects cluster from out-of-band manual modifications.

## Thinking: What would happen if automated sync has `selfHeal: false` after you run `kubectl scale` to change replicas directly in-cluster?

<details>
<summary>Answer</summary>

When `selfHeal: false`:

1. ArgoCD **will NOT revert your manual replica change** back to the value stored in Git.
2. The Application sync status will become `OutOfSync`, because live cluster replica count diverges from Git desired manifest.
3. ArgoCD only reports the drift, but takes no automatic corrective action.
4. You have to trigger a manual sync to restore the Git-defined replica value.

### Short summary (lab submission)

With `selfHeal: false`, manual in-cluster changes remain unchanged, and the application becomes `OutOfSync`. ArgoCD detects the drift but does not auto-revert it. Manual sync is required to restore desired state.

</details>