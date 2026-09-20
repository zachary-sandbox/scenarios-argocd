#!/bin/bash
argocd app get helm-basic-app > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✅ step2 passed: Application accessible for Helm parameter override"
  exit 0
fi
echo "❌ failed to read helm-basic-app"
exit 1
