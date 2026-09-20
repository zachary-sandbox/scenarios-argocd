#!/bin/bash
kubectl get application cli-demo-app -n argocd -o jsonpath="{.spec.syncPolicy.automated}" | grep -q "selfHeal"
if [ $? -eq 0 ];then
    echo "✅ step1 passed: automated sync policy patched to application"
    exit 0
fi
echo "❌ automated syncPolicy not present on application spec"
exit 1
