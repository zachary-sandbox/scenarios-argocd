#!/bin/bash
if kubectl get configmap argocd-cm -n argocd >/dev/null 2>&1;then
  echo "✅ step2 passed: argocd‑cm exists, policy can be modified"
  exit 0
fi
echo "❌ argocd‑cm configmap not found"
exit 1
