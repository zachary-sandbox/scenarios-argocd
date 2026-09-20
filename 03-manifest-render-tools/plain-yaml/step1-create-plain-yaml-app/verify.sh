#!/bin/bash
if argocd app list | grep -q "plain-yaml-app"; then
  echo "✅ step1 passed: plain-yaml-app exists"
  exit 0
fi
echo "❌ plain-yaml-app not found"
exit 1
