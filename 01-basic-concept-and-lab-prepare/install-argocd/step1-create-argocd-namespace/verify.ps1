if(kubectl get ns argocd 2>&1>$null){
    Write-Host "✅ step1 passed: argocd namespace exists"
    exit 0
}
Write-Host "❌ argocd namespace not found"
exit 1
