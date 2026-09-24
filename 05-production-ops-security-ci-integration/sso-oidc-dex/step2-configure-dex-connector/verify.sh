#!/bin/bash
if kubectl get configmap argocd-dex-config -n argocd >/dev/null 2>&1;then
  echo "✅ step2 passed: argocd-dex-config configmap exists"
  exit 0
fi
echo "❌ argocd-dex-config configmap not found"
exit 1
