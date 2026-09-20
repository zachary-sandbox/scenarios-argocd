#!/bin/bash
if kubectl get ns argocd &> /dev/null;then
    echo "✅ step1 passed: argocd namespace exists"
    exit 0
fi
echo "❌ argocd namespace not found"
exit 1
