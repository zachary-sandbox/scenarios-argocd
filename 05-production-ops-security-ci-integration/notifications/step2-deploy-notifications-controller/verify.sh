#!/bin/bash
if kubectl get deployment argocd-notifications-controller -n argocd >/dev/null 2>&1;then
  echo "✅ step2 passed: notifications controller deployment exists"
  exit 0
fi
echo "❌ notifications‑controller deployment not found"
exit 1
