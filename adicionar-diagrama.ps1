# Script para adicionar novos diagramas ao site
# Uso: Clique duas vezes neste arquivo ou execute: .\adicionar-diagrama.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ADICIONAR NOVOS DIAGRAMAS AO SITE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se estamos no diretório correto
if (-not (Test-Path "public\files\diagrams")) {
    Write-Host "ERRO: Execute este script na pasta do projeto!" -ForegroundColor Red
    Write-Host "Caminho esperado: C:\Users\darkf\OneDrive\Documentos\limafluxo" -ForegroundColor Yellow
    pause
    exit 1
}

# Passo 1: Solicitar a pasta com os novos SVGs
Write-Host "PASSO 1: Localize os arquivos SVG" -ForegroundColor Green
Write-Host "Onde estão os novos arquivos SVG?" -ForegroundColor Yellow
Write-Host ""
Write-Host "Opções:" -ForegroundColor White
Write-Host "  1. Digitar o caminho da pasta" -ForegroundColor White
Write-Host "  2. Digitar o caminho de um arquivo SVG específico" -ForegroundColor White
Write-Host ""

$caminho = Read-Host "Cole aqui o caminho completo da pasta ou arquivo"

if (-not (Test-Path $caminho)) {
    Write-Host "ERRO: Caminho não encontrado: $caminho" -ForegroundColor Red
    pause
    exit 1
}

# Encontrar todos os SVGs
$svgs = @()
if ((Get-Item $caminho).PSIsContainer) {
    # É uma pasta - buscar SVGs recursivamente
    $svgs = Get-ChildItem -Path $caminho -Filter "*.svg" -Recurse
} else {
    # É um arquivo
    if ($caminho -like "*.svg") {
        $svgs = @(Get-Item $caminho)
    } else {
        Write-Host "ERRO: O arquivo não é um SVG!" -ForegroundColor Red
        pause
        exit 1
    }
}

if ($svgs.Count -eq 0) {
    Write-Host "ERRO: Nenhum arquivo SVG encontrado!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "Encontrados $($svgs.Count) arquivo(s) SVG:" -ForegroundColor Green
foreach ($svg in $svgs) {
    $tamanhoKB = [math]::Round($svg.Length / 1KB, 2)
    Write-Host "  - $($svg.Name) ($tamanhoKB KB)" -ForegroundColor White
}
Write-Host ""

# Passo 2: Confirmar quais SVGs adicionar
Write-Host "PASSO 2: Selecionar diagramas" -ForegroundColor Green
$selecionados = @()

if ($svgs.Count -eq 1) {
    $confirma = Read-Host "Adicionar este diagrama? (S/N)"
    if ($confirma -eq "S" -or $confirma -eq "s" -or $confirma -eq "") {
        $selecionados += $svgs[0]
    }
} else {
    Write-Host "Digite os números dos diagramas para adicionar (ex: 1,3,4) ou ENTER para todos:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $svgs.Count; $i++) {
        Write-Host "  [$($i+1)] $($svgs[$i].Name)" -ForegroundColor White
    }
    
    $escolha = Read-Host "Sua escolha"
    
    if ($escolha -eq "") {
        $selecionados = $svgs
    } else {
        $indices = $escolha -split "," | ForEach-Object { $_.Trim() }
        foreach ($idx in $indices) {
            if ($idx -match '^\d+$' -and [int]$idx -ge 1 -and [int]$idx -le $svgs.Count) {
                $selecionados += $svgs[[int]$idx - 1]
            }
        }
    }
}

if ($selecionados.Count -eq 0) {
    Write-Host "Nenhum diagrama selecionado. Cancelando..." -ForegroundColor Yellow
    pause
    exit 0
}

Write-Host ""
Write-Host "Serão adicionados $($selecionados.Count) diagrama(s):" -ForegroundColor Green
foreach ($svg in $selecionados) {
    Write-Host "  ✓ $($svg.Name)" -ForegroundColor White
}
Write-Host ""

# Passo 3: Pedir nomes amigáveis para cada diagrama
Write-Host "PASSO 3: Nomear os diagramas no site" -ForegroundColor Green
Write-Host "Digite o nome que aparecerá na barra lateral (ou ENTER para usar o nome do arquivo):" -ForegroundColor Yellow
Write-Host ""

$diagramas = @()
foreach ($svg in $selecionados) {
    $nomeBase = [System.IO.Path]::GetFileNameWithoutExtension($svg.Name)
    $nomeExibicao = Read-Host "Nome para '$($svg.Name)' (ENTER = '$nomeBase')"
    
    if ($nomeExibicao -eq "") {
        $nomeExibicao = $nomeBase
    }
    
    $diagramas += @{
        Arquivo = $svg
        Nome = $nomeExibicao
        Id = [guid]::NewGuid().ToString()
    }
}

# Passo 4: Copiar arquivos
Write-Host ""
Write-Host "PASSO 4: Copiando arquivos..." -ForegroundColor Green

foreach ($diagrama in $diagramas) {
    $destino1 = "public\files\diagrams\$($diagrama.Arquivo.Name)"
    $destino2 = "Tentar publicar\files\diagrams\$($diagrama.Arquivo.Name)"
    
    Copy-Item $diagrama.Arquivo.FullName $destino1 -Force
    Copy-Item $diagrama.Arquivo.FullName $destino2 -Force
    
    Write-Host "  ✓ $($diagrama.Arquivo.Name) copiado" -ForegroundColor White
}

# Passo 5: Atualizar configuration.json.js
Write-Host ""
Write-Host "PASSO 5: Atualizando configuração..." -ForegroundColor Green

# Ler diagramas existentes
$configPath = "public\libs\js\json\configuration.json.js"
$configContent = Get-Content $configPath -Raw

# Extrair o JSON existente
if ($configContent -match 'Bizagi\.AppModel = (.+)') {
    $jsonStr = $matches[1]
    $config = $jsonStr | ConvertFrom-Json
    
    # Adicionar novos diagramas
    foreach ($diagrama in $diagramas) {
        $novoDiagrama = @{
            id = $diagrama.Id
            name = $diagrama.Nome
            version = "1.0"
            author = "Usuário"
            image = "files/diagrams/$($diagrama.Arquivo.Name)"
            isSubprocessPage = $false
            isCallActivityPage = $false
            elements = @()
            subPages = @()
        }
        
        $config.pages += $novoDiagrama
    }
    
    # Atualizar publishDate
    $config.publishDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    
    # Converter de volta para JSON
    $novoJson = $config | ConvertTo-Json -Depth 10 -Compress
    $novoConfig = "Bizagi.AppModel = $novoJson"
    
    # Salvar em ambas as pastas
    [System.IO.File]::WriteAllText("$PWD\public\libs\js\json\configuration.json.js", $novoConfig, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText("$PWD\Tentar publicar\libs\js\json\configuration.json.js", $novoConfig, [System.Text.Encoding]::UTF8)
    
    Write-Host "  ✓ Configuração atualizada com $($config.pages.Count) diagramas" -ForegroundColor White
}

# Passo 6: Git commit e push
Write-Host ""
Write-Host "PASSO 6: Enviando para o site..." -ForegroundColor Green

$mensagemPadrao = "Add: $($diagramas.Count) novo(s) diagrama(s)"
$mensagem = Read-Host "Mensagem do commit (ENTER = '$mensagemPadrao')"

if ($mensagem -eq "") {
    $mensagem = $mensagemPadrao
}

git add -A
git commit -m $mensagem
git push

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✓ CONCLUÍDO COM SUCESSO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Seus novos diagramas foram adicionados:" -ForegroundColor White
foreach ($diagrama in $diagramas) {
    Write-Host "  • $($diagrama.Nome)" -ForegroundColor Cyan
}
Write-Host ""
Write-Host "O site será atualizado em 1-2 minutos em:" -ForegroundColor White
Write-Host "  https://repositorioprocessos.netlify.app" -ForegroundColor Cyan
Write-Host ""
Write-Host "Recarregue a página com Ctrl+F5 para ver as alterações." -ForegroundColor Yellow
Write-Host ""

pause
