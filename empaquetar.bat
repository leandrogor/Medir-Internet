for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set "date=%%G"
set filename=MedirInternet-%date:~6,2%-%date:~4,2%-%date:~0,4%.zip
7z a %filename% medirInternet.py startMedirInternet.bat
