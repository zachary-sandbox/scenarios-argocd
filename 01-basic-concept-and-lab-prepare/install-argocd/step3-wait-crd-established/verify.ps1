if(kubectl get crd applications.argoproj.io 2>&1>$null){
    Write-Host "✅ step3 passed: Application CRD exists"
    exit 0
}
Write-Host "❌ Application CRD not ready, still installing"
exit 1
