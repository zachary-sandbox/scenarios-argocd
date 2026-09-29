# Step3 Add child Application CR in Git

Fork [the example repository](https://github.com/zachary-sandbox/argocd-example-apps.git) to your own account.

Add a new child Application CR YAML file in the `app-of-apps/children` directory:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: child-nginx-dr
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/zachary-sandbox/argocd-example-apps.git
    targetRevision: release/v1.0.0
    path: kustomize-examples/k8s/overlays/dev
  destination:
    server: https://kubernetes.default.svc
    namespace: dr
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

## Thinking: What is the difference between a parent Application and a child Application?

<details>
<summary>Answer</summary>

Parent Application manages child Application CR objects. Its git source folder contains Application YAML manifests, it does not deploy regular workload resources.
Child Application consumes its own git source and deploys real business resources such as Deployment, Service, ConfigMap.

### Short summary (lab submission)

Parent app manages child Application CRs. Child apps deploy actual business kubernetes workload resources.

</details>

## Thinking: What happens when you delete a child Application yaml file from git children folder with parent app `prune=true` enabled?

<details>
<summary>Answer</summary>`

Parent Application detects that child Application manifest is removed from git. Prune will delete that child Application CR from Kubernetes cluster.
Note: Deleting child Application CR will **not automatically delete the workload resources** deployed by that child app, unless orphan resource deletion is configured.

### Short summary (lab submission)`

Parent prune deletes child Application CR, but workloads deployed by child app remain by default.

</details>

## Clean-up lab resources

```
argocd app delete parent-app -y
argocd app delete child-guestbook -y
kubectl delete namespace guestbook
```

