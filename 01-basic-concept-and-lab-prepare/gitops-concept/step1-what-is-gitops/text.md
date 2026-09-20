# Step1 What is GitOps
## Knowledge Points
1. GitOps is a continuous-delivery methodology for Kubernetes. **Git is the single source-of-truth**.
2. Desired State: what you want your Kubernetes environment to look like, defined in Git YAML manifests.
3. Live State: real runtime status inside Kubernetes cluster.
4. Argo-CD controller loops comparing these two states. Any deviation will be flagged as `OutOfSync`.

Thinking Questions:
1. Does OutOfSync always indicate cluster failure?
2. What does the Sync operation actually perform?

Reference document: https://argo-cd.readthedocs.io/en/stable/
