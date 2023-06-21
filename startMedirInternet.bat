@echo off

REM Verificar si Python está instalado
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python no instalado.
	
    REM Abrir la página de detalles de Python 3.11 en la Microsoft Store
    start ms-windows-store://pdp/?ProductId=9NRWMJP3717K
	
    echo Por favor, instala Python desde Microsoft Store y luego vuelve a ejecutar este archivo.
    pause > nul
    exit
)


REM Verificar si speedtest-cli está instalado
speedtest-cli --version >nul 2>&1
if %errorlevel% neq 0 (
    echo speedtest-cli no instalado o correctamente configurado. Verificando...
	
    pip install speedtest-cli >nul 2>&1

    REM Obtener la ruta de speedtest-cli
    set "speedtest_cli_path="
    for /d %%i in ("%USERPROFILE%\AppData\Local\Packages\PythonSoftwareFoundation.Python.*") do (
        for /f %%j in ('dir /b /s "%%~i\LocalCache\local-packages\python*\site-packages\speedtest_cli"') do (
            set "speedtest_cli_path=%%~dpj"
        )
    )

    if "%speedtest_cli_path%"=="" (
        echo No se pudo encontrar la ruta de speedtest-cli.
        echo Por favor, verifica la instalación y configuración de speedtest-cli.
        echo.
        pause > nul
        exit
    )

    echo.
    echo Instrucciones de configuracion:
    echo 1. Abre el menu de inicio y busca "Variables de entorno".
    echo 2. Selecciona "Editar las variables de entorno del sistema".
    echo 3. Haz clic en el boton "Variables de entorno".
    echo 4. En la seccion "Variables del sistema", busca la variable "Path".
    echo 5. Haz clic en el boton "Editar".
    echo 6. Agrega la ruta completa al directorio de speedtest-cli: 
    echo %speedtest_cli_path%
    echo 7. Haz clic en "Aceptar" en todas las ventanas para cerrarlas.
    echo.
	
    echo Una vez realizados todos los pasos, por favor, vuelve a ejecutar este archivo.
	pause > nul
    exit
)


python medirInternet.py
pause > nul
exit
