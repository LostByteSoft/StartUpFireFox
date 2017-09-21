@echo ----------------------------------------------------------
@taskkill /f /im "StartUpFireFox.exe"
cd "%~dp0"
copy "*.exe" "C:\Program Files\"
copy "*.ini" "C:\Program Files\"
copy "*.ico" "C:\Program Files\"
copy "StartUpFireFox.lnk" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\"
echo copy "*.lnk" "%AppData%\Microsoft\Windows\Start Menu\Programs\"
@echo You can close this windows !!!
@echo ----------------------------------------------------------
@"C:\Program Files\StartUpFireFox.exe"
@exit