if(-not (Get-Command kind -ErrorAction SilentlyContinue)){
    Write-Host "❌ kind binary not found in PATH"
    exit 1
}
Write-Host "✅ step1 passed: kind is installed"
exit 0
