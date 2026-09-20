# Step1 Understand App-of-Apps pattern

The App-of-Apps pattern works like this:
1. You store Application CR YAML files in a Git directory.
2. You create one parent Application pointing to that directory.
3. The parent Application reconciles child Application CRs into the cluster.
4. Each child Application then deploys its own Kubernetes resources.

This is a common cluster bootstrapping pattern.

Thinking question:
What is the difference between a parent Application and a child Application?
