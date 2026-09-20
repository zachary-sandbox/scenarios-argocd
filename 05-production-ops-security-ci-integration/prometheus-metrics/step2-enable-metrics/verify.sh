#!/bin/bash
if kubectl get deployment argocd-api-server -n argocd >/dev/null 2>&1;then
  echo "✅ step2 passed: argocd‑api‑server deployment exists"
  exit 0
fi
echo "❌ argocd‑api‑server deployment not found"
exit 1
