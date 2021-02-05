echo on
echo Installer version 1.0
taskkill /im "StartUpFireFox.exe"

copy "*.ico" "C:\Program Files\Common Files\"
copy "*.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"

echo "You must close this command windows"
"C:\Program Files\StartUpFireFox.exe"
exit