$ctx = kubectl config current-context
if($ctx -match "argocd-lab"){
    Write-Host "✅ step2 passed: kubectl context points to argocd-lab"
    exit 0
}
Write-Host "❌ current kubectl context: $ctx, expected argocd-lab"
exit 1
