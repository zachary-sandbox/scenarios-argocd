#!/bin/bash
if kubectl get crd applications.argoproj.io &> /dev/null;then
    echo "✅ step3 passed: Application CRD exists"
    exit 0
fi
echo "❌ Application CRD not ready, still installing"
exit 1
