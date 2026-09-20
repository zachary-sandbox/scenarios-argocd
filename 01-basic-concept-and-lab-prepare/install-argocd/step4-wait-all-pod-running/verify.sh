#!/bin/bash
ns="argocd"
total=$(kubectl get pods -n ${ns} --no-headers | wc -l)
running=$(kubectl get pods -n ${ns} --field-selector=status.phase=Running --no-headers | wc -l)
if [ "${total}" -gt 0 ] && [ "${total}" -eq "${running}" ];then
  echo "✅ step4 passed: All Argo-CD pods are Running"
  exit 0
fi
echo "❌ Pods not fully ready. total:${total} running:${running}"
exit 1
