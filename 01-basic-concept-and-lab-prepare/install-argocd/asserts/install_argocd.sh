#!/bin/bash
set -e

# 1. Create namespace
echo "===== Step1 Create argocd namespace ====="
kubectl create namespace argocd || echo "namespace argocd already exists, skip"

# 2. Apply Argo‑CD stable installation manifests with server‑side apply
echo -e "\n===== Step2 Deploy Argo‑CD stable release ====="
kubectl apply -n argocd --server-side --force-conflicts \
-f /tmp/install.yaml

echo -e "\n===== Step3 Wait for secret argocd-initial-admin-secret to be created ====="
# Poll until secret becomes available; secret is generated after installation completes
until kubectl get secret -n argocd argocd-initial-admin-secret >/dev/null 2>&1; do
    echo "Waiting for argocd-initial-admin-secret secret ..."
    sleep 3
done

# 3. Fetch and decode admin password (secret data is base64‑encoded)
echo -e "\n===== Step4 Retrieve initial admin password ====="
ADMIN_PWD=$(kubectl get secret argocd-initial-admin-secret \
-n argocd \
-o jsonpath="{.data.password}" | base64 -d)

echo "ArgoCD Namespace: argocd"
echo "Username: admin"
echo "Initial Admin Password: ${ADMIN_PWD}"

# Optional: save password to local file
echo "${ADMIN_PWD}" > ./argocd_admin_password.txt
echo -e "\nPassword also saved to local file: ./argocd_admin_password.txt"

# 4. Start port‑forward in background for Argo‑CD Web UI
#kubectl patch svc argocd-server -n argocd --type merge -p '
#{
#  "spec": {
#    "type":"NodePort",
#    "ports": [
#      {
#        "name":"http",
#        "port": 80,
#        "targetPort": 8080,
#        "nodePort": 30080
#      },
#      {
#        "name":"https",
#        "port": 443,
#        "targetPort": 8080,
#        "nodePort": 30443
#      }
#    ]
#  }
#}'
#echo -e "\n===== Step5 Start background port‑forward for Argo‑CD UI ====="
#kubectl port-forward svc/argocd-server -n argocd 30080:80 >/dev/null 2>&1 &
#PF_PID=$!
#echo "Port‑forward background PID: ${PF_PID}"
#echo "Argo‑CD Web UI URL: https://127.0.0.1:8080"
#echo "To stop port‑forward manually, execute: kill ${PF_PID}"

# Optional: auto‑login using argocd CLI
#echo -e "\n===== Step6 Try argocd CLI login ====="
#argocd login https://cdac3975fe6801fc-1-30080.papa.r.killercoda.com --username admin --password "$85JpZdUMOUWMzcJ4" --insecure
