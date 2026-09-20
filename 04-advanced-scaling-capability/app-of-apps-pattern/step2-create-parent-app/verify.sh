#!/bin/bash
if argocd app list | grep -q "parent-app"; then
  echo "✅ step2 passed: parent-app created"
  exit 0
fi
echo "❌ parent-app not found"
exit 1
