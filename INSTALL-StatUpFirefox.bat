echo off
pushd "%~dp0
@echo -------------------------------------
echo LostByteSoft
echo Install version 2.1 2021-06-30
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11

echo Software: StartUpFirefox
@echo -------------------------------------
taskkill /im "StartUpFireFox.exe"
@echo copy "SharedIcons\*.ico" "C:\Program Files\Common Files"
@echo -------------------------------------
copy "StartUpFireFox.exe" "C:\Program Files\"
copy "StartUpFireFox.lnk" "C:\Users\Public\Desktop\"
@echo -------------------------------------
echo "You must close this command windows"
"C:\Program Files\StartUpFireFox.exe"
exit