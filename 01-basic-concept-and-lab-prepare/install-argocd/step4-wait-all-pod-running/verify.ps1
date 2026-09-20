$ns="argocd"
$allPods=@(kubectl get pods -n $ns --no-headers)
$runningPods=@(kubectl get pods -n $ns --field-selector=status.phase=Running --no-headers)
if($allPods.Count -gt 0 -and $allPods.Count -eq $runningPods.Count){
    Write-Host "✅ step4 passed: All Argo-CD pods are Running"
    exit 0
}
Write-Host "❌ Pods not fully ready. total:$($allPods.Count) running:$($runningPods.Count)"
exit 1
