#!/bin/bash
if argocd app list | grep -q "guestbook-app";then
    echo "✅ step1 passed: guestbook‑app application created"
    exit 0
fi
echo "❌ guestbook‑app not found, execute argocd app create"
exit 1
