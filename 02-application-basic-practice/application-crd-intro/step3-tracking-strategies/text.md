# Step3 Git tracking strategies for targetRevision
Argo‑CD supports three major tracking modes for spec.source.targetRevision:

1. **Track branch**: e.g `main`
> Continuously follow latest commits on given git branch. Every new commit to branch triggers reconciliation check.

2. **Track tag**: e.g `v1.2.0`
> Follow git tag. If tag is moved (mutable tag), Argo‑CD picks new target. Prefer immutable tags.

3. **Pin to exact commit hash**: e.g `a1b2c3d`
> Fixed to one specific git commit. Will not react to new commits or tag movements. Highest stability for production.

Reference doc: https://argo-cd.readthedocs.io/en/stable/user-guide/tracking_strategies/

Thinking: Which strategy you would pick for production environment?
