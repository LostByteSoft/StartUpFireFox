@PATH C:\Program Files\AutoHotkey\Compiler;C:\windows\system32
@if not exist "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" goto notins
@taskkill /F /IM "StartUpFireFox.exe"
Ahk2Exe.exe /in "StartUpFireFox.ahk" /out "StartUpFireFox.exe" /icon "ico_ff_red.ico" /mpress "0"
@exit

:notins
@echo Ahk is not installed.
@pause

:exit
@exit