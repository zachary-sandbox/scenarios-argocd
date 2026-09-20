#!/bin/bash
if argocd app list | grep -q "argocd-self"; then
  echo "✅ step3 passed: argocd-self Application exists"
  exit 0
fi
echo "❌ argocd-self not found"
exit 1
