#!/bin/bash
if kubectl get deployment argocd-repo-server -n argocd > /dev/null 2>&1; then
  echo "✅ step2 passed: argocd-repo-server exists for plugin injection"
  exit 0
fi
echo "❌ argocd-repo-server deployment not found"
exit 1
