#!/bin/bash
if command -v kubectl &> /dev/null; then
  echo "✅ step1 passed: kubectl available for kustomize rendering"
  exit 0
fi
echo "❌ kubectl not found"
exit 1
