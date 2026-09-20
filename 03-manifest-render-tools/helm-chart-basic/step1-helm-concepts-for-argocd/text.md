# Step1 Helm concepts for Argo CD

Helm charts are packaged Kubernetes applications.
Argo CD supports Helm by rendering templates into YAML manifests.

Key concepts:
- Chart: packaged application template
- Values: configurable inputs
- Release: deployed instance of a chart

Important:
Argo CD does not use Helm v2 Tiller.
It renders the chart locally inside repo-server and applies the resulting manifests.

Reference: https://argo-cd.readthedocs.io/en/stable/user-guide/helm/
