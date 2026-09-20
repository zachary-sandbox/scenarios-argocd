if(-not (Get-Command argocd -ErrorAction SilentlyContinue)){
    Write-Host "❌ argocd cli binary not found"
    exit 1
}
Write-Host "✅ step1 passed: argocd cli installed"
exit 0
