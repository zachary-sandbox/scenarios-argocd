#!/bin/bash
if ! argocd app list | grep -q "guestbook-app";then
    echo "✅ step3 passed: guestbook-app Application CR has been deleted"
    exit 0
fi
echo "❌ guestbook-app Application CR still exists, run argocd app delete"
exit 1
