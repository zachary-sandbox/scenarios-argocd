#!/bin/bash
if kubectl get applicationset -n argocd list-generator-demo > /dev/null 2>&1; then
  echo "✅ step2 passed: list-generator-demo ApplicationSet exists"
  exit 0
fi
echo "❌ list-generator-demo not found"
exit 1
