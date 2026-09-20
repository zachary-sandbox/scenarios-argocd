#!/bin/bash
if kubectl get job -n hooks-demo post-sync-job > /dev/null 2>&1; then
  echo "✅ step2 passed: post-sync-job created"
  exit 0
fi
echo "❌ post-sync-job not found"
exit 1
