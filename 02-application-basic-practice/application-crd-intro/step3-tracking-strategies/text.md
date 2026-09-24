# Step3 Git tracking strategies for targetRevision

Argo-CD supports three major tracking modes for spec.source.targetRevision:

1. **Track branch**: e.g. `main` > Continuously follow latest commits on given git branch. Every new commit to branch triggers reconciliation check.
2. **Track tag**: e.g. `v1.2.0` > Follow git tag. If tag is moved (mutable tag), Argo-CD picks new target. Prefer immutable tags.
3. **Pin to exact commit hash**: e.g. `a1b2c3d` > Fixed to one specific git commit. Will not react to new commits or tag movements. Highest stability for production.

Reference doc: [https://argo-cd.readthedocs.io/en/stable/user-guide/tracking_strategies/](https://argo-cd.readthedocs.io/en/stable/user-guide/tracking_strategies/)

## Thinking: Which strategy you would pick for production environment?

<details>
<summary>Answer</summary>

For production environments, **pinning to an exact commit hash is the most recommended strategy**.

### Reasoning

1. **Exact commit hash (best for production)**
   The commit SHA is immutable. ArgoCD will always reconcile against this fixed commit. It will not automatically pick up new commits, branch updates or moved tags. This prevents unintended automatic deployment of untested changes and guarantees reproducibility. Rollback is straightforward by switching to a previous known-good commit hash.
2. **Track immutable tag (acceptable alternative)**
   Immutable version tags (tags that are never moved after creation, e.g. `v1.2.0`) are also acceptable. But you must ensure the tag is never force-overwritten. Risk exists if someone accidentally moves the tag.
3. **Track branch (NOT recommended for production)**
   Tracking a branch like `main` automatically deploys every new commit merged into the branch. This can push unvalidated changes directly to production and increases the chance of outages. It is suitable for dev/staging environments only.

### Short summary (lab submission)

Use an **exact commit hash** for production. It provides immutability and prevents accidental deployment of new changes. Immutable tags can be used as an alternative, while branch tracking should be reserved for non-production environments.
</details>