#!/bin/bash
argocd app sync cli-demo-app > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "✅ step3 passed: argocd app sync command executed successfully"
    exit 0
fi
echo "❌ argocd app sync execution failed"
exit 1
