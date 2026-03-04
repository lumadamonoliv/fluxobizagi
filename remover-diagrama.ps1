# Script para remover diagramas do site
# Uso: Clique duas vezes neste arquivo ou execute: .\remover-diagrama.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  REMOVER DIAGRAMAS DO SITE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se estamos no diretório correto
if (-not (Test-Path "public\files\diagrams")) {
    Write-Host "ERRO: Execute este script na pasta do projeto!" -ForegroundColor Red
    pause
    exit 1
}

# Listar diagramas existentes
Write-Host "Diagramas atuais no site:" -ForegroundColor Green
Write-Host ""

$svgs = Get-ChildItem "public\files\diagrams\*.svg"

if ($svgs.Count -eq 0) {
    Write-Host "Nenhum diagrama encontrado!" -ForegroundColor Yellow
    pause
    exit 0
}

for ($i = 0; $i -lt $svgs.Count; $i++) {
    $tamanhoKB = [math]::Round($svgs[$i].Length / 1KB, 2)
    Write-Host "  [$($i+1)] $($svgs[$i].Name) ($tamanhoKB KB)" -ForegroundColor White
}

Write-Host ""
Write-Host "Digite os números dos diagramas para REMOVER (ex: 1,3):" -ForegroundColor Yellow
Write-Host "ou digite 0 para cancelar" -ForegroundColor Yellow
Write-Host ""

$escolha = Read-Host "Sua escolha"

if ($escolha -eq "0" -or $escolha -eq "") {
    Write-Host "Operação cancelada." -ForegroundColor Yellow
    pause
    exit 0
}

# Processar escolha
$indices = $escolha -split "," | ForEach-Object { $_.Trim() }
$paraRemover = @()

foreach ($idx in $indices) {
    if ($idx -match '^\d+$' -and [int]$idx -ge 1 -and [int]$idx -le $svgs.Count) {
        $paraRemover += $svgs[[int]$idx - 1]
    }
}

if ($paraRemover.Count -eq 0) {
    Write-Host "Nenhum diagrama válido selecionado." -ForegroundColor Yellow
    pause
    exit 0
}

# Confirmar remoção
Write-Host ""
Write-Host "ATENÇÃO: Os seguintes diagramas serão REMOVIDOS:" -ForegroundColor Red
foreach ($svg in $paraRemover) {
    Write-Host "  ✗ $($svg.Name)" -ForegroundColor Red
}
Write-Host ""

$confirma = Read-Host "Tem certeza? Digite 'SIM' para confirmar"

if ($confirma -ne "SIM") {
    Write-Host "Operação cancelada." -ForegroundColor Yellow
    pause
    exit 0
}

# Remover arquivos SVG
Write-Host ""
Write-Host "Removendo arquivos..." -ForegroundColor Green

foreach ($svg in $paraRemover) {
    $arquivo1 = "public\files\diagrams\$($svg.Name)"
    $arquivo2 = "Tentar publicar\files\diagrams\$($svg.Name)"
    
    if (Test-Path $arquivo1) {
        Remove-Item $arquivo1 -Force
        Write-Host "  ✓ Removido: public\files\diagrams\$($svg.Name)" -ForegroundColor White
    }
    
    if (Test-Path $arquivo2) {
        Remove-Item $arquivo2 -Force
        Write-Host "  ✓ Removido: Tentar publicar\files\diagrams\$($svg.Name)" -ForegroundColor White
    }
}

# Atualizar configuration.json.js
Write-Host ""
Write-Host "Atualizando configuração..." -ForegroundColor Green

$configPath = "public\libs\js\json\configuration.json.js"
$configContent = Get-Content $configPath -Raw

if ($configContent -match 'Bizagi\.AppModel = (.+)') {
    $jsonStr = $matches[1]
    $config = $jsonStr | ConvertFrom-Json
    
    # Remover diagramas da configuração
    $nomesRemover = $paraRemover | ForEach-Object { $_.Name }
    $config.pages = $config.pages | Where-Object { 
        $imagemNome = Split-Path $_.image -Leaf
        $nomesRemover -notcontains $imagemNome
    }
    
    # Limpar searchMap
    $config.searchMap = @()
    
    # Atualizar publishDate
    $config.publishDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    
    # Converter de volta para JSON
    $novoJson = $config | ConvertTo-Json -Depth 10 -Compress
    $novoConfig = "Bizagi.AppModel = $novoJson"
    
    # Salvar em ambas as pastas
    [System.IO.File]::WriteAllText("$PWD\public\libs\js\json\configuration.json.js", $novoConfig, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText("$PWD\Tentar publicar\libs\js\json\configuration.json.js", $novoConfig, [System.Text.Encoding]::UTF8)
    
    Write-Host "  ✓ Configuração atualizada. Restam $($config.pages.Count) diagrama(s)" -ForegroundColor White
}

# Git commit e push
Write-Host ""
Write-Host "Enviando para o site..." -ForegroundColor Green

$mensagem = "Remove: $($paraRemover.Count) diagrama(s)"
git add -A
git commit -m $mensagem
git push

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✓ CONCLUÍDO COM SUCESSO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Diagramas removidos:" -ForegroundColor White
foreach ($svg in $paraRemover) {
    Write-Host "  ✗ $($svg.Name)" -ForegroundColor Red
}
Write-Host ""
Write-Host "O site será atualizado em 1-2 minutos." -ForegroundColor White
Write-Host ""

pause
