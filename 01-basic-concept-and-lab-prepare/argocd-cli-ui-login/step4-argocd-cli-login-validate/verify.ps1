argocd version | Out-Null
if($LASTEXITCODE -eq 0){
    Write-Host "✅ step4 passed: argocd cli authenticated and connected to server"
    exit 0
}
Write-Host "❌ argocd cli login failed, check login credentials"
exit 1
