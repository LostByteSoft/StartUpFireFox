@PATH C:\Program Files\AutoHotkey\Compiler;C:\Program Files\AutoHotkey;C:\windows\system32
@taskkill /im "StartUpFireFox.exe"
@if not exist "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" goto notins
@if exist "C:\Program Files\AutoHotkey\mpress.exe" goto mpress

Ahk2Exe.exe /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /in "StartUpFireFox.ahk" /out "StartUpFireFox.exe" /icon "ProgIcons/ico_ff_red.ico" /mpress "0"
@goto exit

:mpress
Ahk2Exe.exe /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /in "StartUpFireFox.ahk" /out "StartUpFireFox.exe" /icon "ProgIcons/ico_ff_red.ico" /mpress "1"
@goto exit

:notins
@echo Ahk is not installed.
@goto exit

:exit
@exit