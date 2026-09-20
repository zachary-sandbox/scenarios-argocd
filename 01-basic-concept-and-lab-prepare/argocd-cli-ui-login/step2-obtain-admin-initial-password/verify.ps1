if(kubectl get secret argocd-initial-admin-secret -n argocd 2>&1>$null){
    Write-Host "✅ step2 passed: admin initial secret exists"
    exit 0
}
Write-Host "❌ argocd-initial-admin-secret not found"
exit 1
