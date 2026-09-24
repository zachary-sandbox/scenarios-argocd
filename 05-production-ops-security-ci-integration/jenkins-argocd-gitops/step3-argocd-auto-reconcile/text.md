# Step3 Argo-CD auto reconcile after git commit

After Jenkins push new commit to manifest git repo:

1. Argo-CD repo-server periodic pull detect new git revision.
2. repo-server re-render manifests.
3. application-controller compare desired vs live state, detect difference.
4. If syncPolicy automated enabled, trigger auto sync.
5. Kubernetes perform rolling update for workload pods.

Verify workflow result:

```bash
argocd app get my-app
kubectl get pods -n target-ns
```

This completes full GitOps CI-CD loop from source code commit to k8s workload rollout.
