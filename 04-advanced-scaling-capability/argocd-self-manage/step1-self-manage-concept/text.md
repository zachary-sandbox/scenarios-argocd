# Step1 Understand self-management

Self-management means:
1. Argo CD YAML manifests are stored in Git
2. An Application points to those manifests
3. Argo CD reconciles itself like any other application

Benefits:
- Declarative Argo CD installation
- Version-controlled configuration
- Audit history

Risks:
- Breaking changes can disable Argo CD
- Prune mistakes can delete Argo CD resources

Thinking question:
Why is self-management more advanced than a one-time manual install?
