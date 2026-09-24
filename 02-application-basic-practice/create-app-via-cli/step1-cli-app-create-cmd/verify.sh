#!/bin/bash
if argocd app list | grep -q "cli-demo-app";then
    echo "✅ step1 passed: cli-demo-app created via argocd cli"
    exit 0
fi
echo "❌ cli-demo-app not found, run argocd app create command"
exit 1
