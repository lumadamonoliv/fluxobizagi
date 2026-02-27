# ========================================
# Script de Deploy Automático - LumaFluxo
# ========================================
# 
# Como usar:
# 1. Exporte seu diagrama do Bizagi
# 2. Coloque os arquivos na pasta 'public'
# 3. Execute este script (clique duplo ou digite: .\deploy.ps1)
# 
# O script fará commit e push automático para o GitHub
# O Netlify detectará e fará o deploy automaticamente!
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Deploy Automático - LumaFluxo" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se estamos no diretório correto
if (-not (Test-Path "netlify.toml")) {
    Write-Host "ERRO: Execute este script na pasta raiz do projeto!" -ForegroundColor Red
    Write-Host "Navegue até: C:\Users\darkf\OneDrive\Documentos\lumafluxo" -ForegroundColor Yellow
    pause
    exit 1
}

# Verificar status do Git
Write-Host "Verificando alterações..." -ForegroundColor Yellow
$status = git status --porcelain

if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host ""
    Write-Host "Nenhuma alteração detectada!" -ForegroundColor Green
    Write-Host "O site já está atualizado." -ForegroundColor Green
    Write-Host ""
    pause
    exit 0
}

# Mostrar arquivos alterados
Write-Host ""
Write-Host "Arquivos alterados:" -ForegroundColor Cyan
git status --short
Write-Host ""

# Solicitar descrição do commit
$defaultMessage = "Atualização de diagramas - $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
Write-Host "Digite uma descrição da atualização" -ForegroundColor Yellow
Write-Host "(Pressione ENTER para usar: '$defaultMessage')" -ForegroundColor Gray
$commitMessage = Read-Host "Descrição"

if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = $defaultMessage
}

# Fazer commit e push
Write-Host ""
Write-Host "Preparando arquivos..." -ForegroundColor Yellow
git add -A

Write-Host "Criando commit..." -ForegroundColor Yellow
git commit -m "$commitMessage"

Write-Host "Enviando para GitHub..." -ForegroundColor Yellow
git push

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  DEPLOY INICIADO COM SUCESSO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "O Netlify está fazendo o deploy automaticamente." -ForegroundColor Cyan
Write-Host "Seu site será atualizado em aproximadamente 1-2 minutos." -ForegroundColor Cyan
Write-Host ""
Write-Host "Acesse: https://app.netlify.com/sites/SEU-SITE/deploys" -ForegroundColor White
Write-Host "para acompanhar o progresso." -ForegroundColor White
Write-Host ""
pause
