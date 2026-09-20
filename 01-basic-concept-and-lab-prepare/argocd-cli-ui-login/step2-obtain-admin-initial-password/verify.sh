#!/bin/bash
if kubectl get secret argocd-initial-admin-secret -n argocd &> /dev/null;then
    echo "✅ step2 passed: admin initial secret exists"
    exit 0
fi
echo "❌ argocd-initial-admin-secret not found"
exit 1
