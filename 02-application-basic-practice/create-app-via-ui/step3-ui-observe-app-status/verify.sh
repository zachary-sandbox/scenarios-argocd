#!/bin/bash
if kubectl get application -n argocd ui-demo-app &> /dev/null;then
    echo "✅ step3 passed: Application ui-demo-app resource exists"
    exit 0
fi
echo "❌ Application ui-demo-app not found, check UI create operation"
exit 1
