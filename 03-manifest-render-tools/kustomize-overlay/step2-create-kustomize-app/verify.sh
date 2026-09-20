#!/bin/bash
if argocd app list | grep -q "kustomize-app"; then
  echo "✅ step2 passed: kustomize-app created"
  exit 0
fi
echo "❌ kustomize-app not found"
exit 1
