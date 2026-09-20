#!/bin/bash
argocd app get cli-demo-app > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "✅ step2 passed: can retrieve application info by argocd app get"
    exit 0
fi
echo "❌ fail to get application info"
exit 1
