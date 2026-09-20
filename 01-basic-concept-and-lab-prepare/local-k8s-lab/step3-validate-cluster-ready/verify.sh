#!/bin/bash
readyStatus=$(kubectl get nodes -o jsonpath="{.items[0].status.conditions[?(@.type==\"Ready\")].status}")
if [ "${readyStatus}" == "True" ];then
    echo "✅ step3 passed: Kubernetes node is Ready"
    exit 0
fi
echo "❌ Kubernetes node not Ready"
exit 1
