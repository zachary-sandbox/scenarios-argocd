#!/bin/bash
if kubectl get application -n argocd yaml-demo-app &> /dev/null;then
    echo "✅ step3 passed: yaml-demo-app created via kubectl apply declarative yaml"
    exit 0
fi
echo "❌ yaml-demo-app Application CR not found"
exit 1
