#!/bin/bash
if ! command -v argocd &> /dev/null
then
    echo "❌ argocd cli binary not found"
    exit 1
fi
echo "✅ step1 passed: argocd cli installed"
exit 0
