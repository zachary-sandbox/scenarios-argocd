# Step1 CI / CD separation GitOps pattern

Traditional pipeline:
Jenkins build image → kubectl apply directly modify kubernetes cluster.

GitOps split duties:
✅ Jenkins CI duties:
1. Compile / build source code
2. Build docker image
3. Push image to container registry
4. **Commit new image tag value into Git manifest repository**

✅ Argo‑CD CD duties:
1. Periodically fetch Git repository
2. Detect manifest changes
3. Render Helm/Kustomize manifests
4. Sync desired state to Kubernetes cluster

> Critical point: Jenkins does NOT hold kubeconfig credentials to access k8s cluster.
