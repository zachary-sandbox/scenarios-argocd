# Step1 Understand ApplicationSet

ApplicationSet CRD has two key parts:
- Generators: define where parameters come from
- Template: defines the Application CR to generate

Common generators:
- List generator
- Git directory generator
- Cluster generator

ApplicationSet is powerful for scaling patterns like:
- one app per environment
- one app per cluster
- one app per team

Reference: https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/
