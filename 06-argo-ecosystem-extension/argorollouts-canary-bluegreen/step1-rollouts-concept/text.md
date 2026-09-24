# Step1 Argo Rollouts core concept

Native Kubernetes Deployment limitation:
- Only supports rolling-update strategy, simple proportional pod scaling.
- No native canary traffic splitting, no blue-green full swap, no built-in analysis.

Argo Rollouts provides new CRD :
- Canary release: gradually shift traffic to new version, support analysis / judgement before full promotion.
- Blue-Green release: spin-up complete new replica set, switch service selector, old version kept for rollback.
- Integration with Argo-CD: Argo-CD treats Rollout CR as ordinary Kubernetes resource and sync from Git.

Thinking question:
What is the division of responsibilities between Argo-CD and Argo Rollouts?
