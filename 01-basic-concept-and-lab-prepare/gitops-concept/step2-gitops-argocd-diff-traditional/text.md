# Step2 GitOps vs Traditional Delivery Mode

## Traditional CI Pipeline Pattern

CI pipeline completes source‑code compilation, builds container images, then the pipeline executes imperative `kubectl apply` / `kubectl patch` commands to modify Kubernetes cluster resources directly.
The CI job holds `kubeconfig` credentials which grant full access to target Kubernetes clusters.

>
> **Drawbacks**
>
> - Change history is **NOT persisted in Git**. Deployment changes are only recorded in CI job logs instead of version‑controlled Git repository.
> - Ad‑hoc manual edits inside cluster cannot be tracked. Operators run `kubectl edit` to hot‑fix issues; those runtime modifications exist only inside cluster with no Git record.
> - Rollback process is error‑prone. To rollback you need to re‑run an old CI job; you cannot guarantee exactly the same manifest will be reapplied.
> - Credential exposure risk: CI agents carry cluster credentials. Compromised CI runner may lead to full cluster takeover.
> - Environment drift easily occurs: live cluster state gradually diverges from configuration stored in source code repository.

## GitOps Pattern

1. CI pipeline **only builds and pushes container images**. CI never calls Kubernetes API directly. Instead, CI updates image tag values inside the **Git manifest repository**, then commits and pushes the modification to Git.
2. Argo‑CD components (Repo‑Server + Application‑Controller) continuously read the Git manifest repository. It compares desired state from Git against live state inside Kubernetes cluster.
3. When difference is detected, Argo‑CD applies manifests to converge cluster toward Git‑defined desired state.
4. All configuration changes are captured as Git commits, with complete audit log including author, timestamp and change content.

>
> **Core advantages summary**
>
> - Git becomes single source‑of‑truth for all Kubernetes desired‑state manifests.
> - No cluster credentials stored within CI pipeline, reducing attack surface.
> - Rollback is simple: revert a Git commit; Argo‑CD will reconcile automatically.
> - Every configuration change can go through Pull Request review before landing on cluster.

## Thinking points

### 1. What are benefits when CI pipeline never directly touches Kubernetes API?

<details>
<summary>Answer</summary>

1. **Security improvement**: CI agents / runners do not need kubeconfig credentials for Kubernetes. Even if CI pipeline or runner is compromised, attackers cannot gain access to modify the Kubernetes cluster. This greatly reduces security attack surface.
2. **Clear separation of duties**: CI is responsible for building artifacts (compile code, build & push images). CD responsibility belongs exclusively to Argo‑CD running inside the cluster. CI and CD concerns are decoupled.
3. **Complete audit trail**: All configuration modifications must be committed to Git. Git commit history records every manifest change, rather than scattered CI job logs.
4. **Consistent rollback mechanism**: Rollback is performed by reverting Git commit, independent of CI tool. You are not dependent on re‑executing old CI jobs which may produce different artifacts.
5. **Multi‑environment consistency**: Dev, staging, production all consume manifests from Git repository, avoiding environment‑specific imperative CI logic.

</details>

### 2. If user manually edits resources inside cluster, what will Argo‑CD do with self‑heal enabled?

<details>
<summary>Answer</summary>

When `selfHeal: true` is set in `syncPolicy`:
1. Argo‑CD reconciliation loop detects drift: live cluster resource has diverged from desired state defined in Git repository, marks Application status as `OutOfSync`.
2. Argo‑CD will automatically overwrite the manual edits inside cluster, restoring resources back to exactly the state described in Git manifests.
3. Manual runtime changes will be lost.

> Note: If self‑heal is disabled (`selfHeal: false`), Argo‑CD will still report `OutOfSync` status, but will NOT automatically revert manual cluster modifications. Operator needs to trigger sync manually to restore Git‑defined desired state.

</details>

Reference document: [https://argo‑cd.readthedocs.io/en/stable/user-guide/gitops/](https://argo-cd.readthedocs.io/en/stable/user-guide/gitops/)
