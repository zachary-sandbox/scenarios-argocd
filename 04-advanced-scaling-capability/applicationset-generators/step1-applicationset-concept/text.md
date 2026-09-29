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

Reference: [https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/)

## Core concept

1. **Generator**: Produces a set of parameter values (key‑value pairs). Each set of parameters renders one Application from template.
2. **Template**: An Application template with placeholders `${parameter_name}`, placeholders get substituted by generator output values.
3. ApplicationSet creates / manages multiple Application CRs automatically. When generator parameters change, child Applications are updated or pruned.
