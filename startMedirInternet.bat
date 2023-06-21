@echo off
setlocal enabledelayedexpansion

REM Verificar si Python está instalado
python --version >nul 2>&1
if !errorlevel! neq 0 (
    echo Python no instalado.
	
    REM Abrir la página de detalles de Python 3.11 en la Microsoft Store
    start ms-windows-store://pdp/?ProductId=9NRWMJP3717K
	
    echo Por favor, instala Python desde Microsoft Store y luego vuelve a ejecutar este archivo.
    pause > nul
    exit
)


REM Verificar si speedtest-cli está instalado
speedtest-cli --version >nul 2>&1
if !errorlevel! neq 0 (
    echo speedtest-cli no instalado o correctamente configurado. Verificando...
	
    pip install speedtest-cli >nul 2>&1
	
    REM Obtener la ruta de speedtest-cli
	for /d %%i in ("%USERPROFILE%\AppData\Local\Packages\Python*") do (
		set speedtest_cli_path=%%~i\LocalCache\local-packages\Python311\Scripts 
	)

	if "!speedtest_cli_path!"=="" (
		echo No se pudo encontrar la ruta de speedtest-cli.
		echo Por favor, verifica la instalacion y configuracion de speedtest-cli.
		pause > nul
		exit
	)

	REM Convertir la ruta a una ruta absoluta
	pushd "!speedtest_cli_path!"
	set "speedtest_cli_path=!CD!"
	popd 

	REM Añadir la ruta al PATH
	setx PATH "%PATH%;!speedtest_cli_path!" >nul 2>&1

    echo.
    echo Instrucciones de configuracion:
    echo 1. Abre el menu de inicio y busca "Variables de entorno".
    echo 2. Selecciona "Editar las variables de entorno del sistema".
    echo 3. Haz clic en el boton "Variables de entorno".
    echo 4. En la seccion "Variables del sistema", busca la variable "Path".
    echo 5. Haz clic en el boton "Editar".
    echo 6. Agrega la siguiente ruta: 
    echo !speedtest_cli_path!
    echo 7. Haz clic en "Aceptar" en todas las ventanas para cerrarlas.
    echo.
	
    echo Una vez realizados todos los pasos, por favor, vuelve a ejecutar este archivo.
	pause > nul
    exit
)


python medirInternet.py
