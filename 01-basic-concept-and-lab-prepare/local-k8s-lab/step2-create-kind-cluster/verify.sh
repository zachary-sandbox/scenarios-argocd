#!/bin/bash
ctx=$(kubectl config current-context)
if [[ "${ctx}" == *"argocd-lab"* ]];then
  echo "✅ step2 passed: kubectl context points to argocd-lab"
  exit 0
fi
echo "❌ current kubectl context: ${ctx}, expected argocd-lab"
exit 1
