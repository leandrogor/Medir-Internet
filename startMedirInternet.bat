@echo off

REM Verificar si Python está instalado
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python no está instalado.
    REM Abrir la página de detalles de Python 3.11 en la Microsoft Store
    start ms-windows-store://pdp/?ProductId=9NRWMJP3717K
    echo Por favor, instala Python desde Microsoft Store y luego vuelve a ejecutar este archivo.
    pause
    exit
)

python medirInternet.py
