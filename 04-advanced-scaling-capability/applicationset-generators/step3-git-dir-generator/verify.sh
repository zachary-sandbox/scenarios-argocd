#!/bin/bash
if kubectl get applicationset -n argocd git-dir-demo > /dev/null 2>&1; then
  echo "✅ step3 passed: git-dir-demo ApplicationSet exists"
  exit 0
fi
echo "❌ git-dir-demo not found"
exit 1
