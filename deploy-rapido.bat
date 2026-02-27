@echo off
REM ========================================
REM Script de Deploy Rápido - LumaFluxo
REM ========================================
chcp 65001 >nul

echo ========================================
echo   Deploy Automático - LumaFluxo
echo ========================================
echo.

cd /d "%~dp0"

if not exist "netlify.toml" (
    echo ERRO: Execute este script na pasta raiz do projeto!
    pause
    exit /b 1
)

echo Verificando alterações...
git status --short
echo.

set /p "commit=Digite uma descrição (ou ENTER para usar padrão): "
if "%commit%"=="" set "commit=Atualização de diagramas - %date% %time%"

echo.
echo Enviando alterações...
git add -A
git commit -m "%commit%"
git push

echo.
echo ========================================
echo   DEPLOY INICIADO COM SUCESSO!
echo ========================================
echo.
echo O site será atualizado em 1-2 minutos.
echo.
pause
