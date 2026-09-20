# Step1 Understand multi-cluster management

Argo CD multi-cluster model:
1. Control plane runs in one cluster
2. Other clusters are registered as remote targets
3. Applications specify destination cluster by name or server URL

Security considerations:
- Cluster credentials must be protected
- Use least-privilege service accounts on remote clusters
- Avoid storing admin kubeconfigs in plaintext

Thinking question:
Why is it important to restrict permissions on remote cluster credentials?
