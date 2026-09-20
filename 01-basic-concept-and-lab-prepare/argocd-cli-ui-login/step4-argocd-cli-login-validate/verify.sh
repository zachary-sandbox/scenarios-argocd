#!/bin/bash
argocd version > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "✅ step4 passed: argocd cli authenticated and connected to server"
    exit 0
fi
echo "❌ argocd cli login failed, check login credentials"
exit 1
