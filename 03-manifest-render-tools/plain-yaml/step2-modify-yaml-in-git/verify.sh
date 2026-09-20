#!/bin/bash
argocd app get plain-yaml-app > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✅ step2 passed: Application still exists after Git update"
  exit 0
fi
echo "❌ failed to read plain-yaml-app"
exit 1
