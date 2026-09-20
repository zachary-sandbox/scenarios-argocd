#!/bin/bash
if kubectl get deployment -n argo-rollouts argo-rollouts-controller > /dev/null 2>&1; then
  echo "✅ step2 passed: argo‑rollouts‑controller deployment exists"
  exit 0
fi
echo "❌ argo‑rollouts‑controller not found"
exit 1
