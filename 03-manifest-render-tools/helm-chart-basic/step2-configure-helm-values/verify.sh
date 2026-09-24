#!/bin/bash
if argocd app list | grep -q "helm-basic-app"; then
  echo "✅ step2 passed: helm-basic-app created"
  exit 0
fi
echo "❌ helm-basic-app not found"
exit 1
