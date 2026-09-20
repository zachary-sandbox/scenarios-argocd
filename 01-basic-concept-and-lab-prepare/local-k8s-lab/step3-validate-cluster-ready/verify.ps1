$readyStatus = kubectl get nodes -o jsonpath="{.items[0].status.conditions[?(@.type==\"Ready\")].status}"
if($readyStatus -eq "True"){
    Write-Host "✅ step3 passed: Kubernetes node is Ready"
    exit 0
}
Write-Host "❌ Kubernetes node not Ready"
exit 1
