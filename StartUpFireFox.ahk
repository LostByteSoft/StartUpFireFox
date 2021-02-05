;;--- Head --- Informations --- AHK ---

;;	Firefox startup
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	SetTitleMatchMode, 2
	SetTitleMatchMode, Slow
	#NoEnv
	#SingleInstance Force
	#Persistent
	DetectHiddenText, On

	SetEnv, title, StartUp FireFox
	SetEnv, mode, FF Start Options
	SetEnv, version, Version 2021-02-04
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files
	SetEnv, logoicon, ico_ff_red.ico

	;; specific files

	FileInstall, StartUpFireFox.ini, StartUpFireFox.ini,0
	FileInstall, ico_ff_blue.ico, %icofolder%\ico_ff_blue.ico, 0
	FileInstall, ico_ff_red.ico, %icofolder%\ico_ff_red.ico, 0
	FileInstall, ico_Save.ico, %icofolder%\ico_Save.ico, 0
	FileInstall, ico_maximize.ico, %icofolder%\ico_maximize.ico, 0
	FileInstall, ico_secret.ico, %icofolder%\ico_secret.ico, 0

	;; Common ico

	FileInstall, ico_minimize.ico, %icofolder%\ico_minimize.ico, 0
	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0

	IniRead, delay, StartUpFireFox.ini, options, delay
	IniRead, minimize, StartUpFireFox.ini, options, minimize
	IniRead, Maximize, StartUpFireFox.ini, options, Maximize
	IniRead, path, StartUpFireFox.ini, options, path
	IniRead, autorun, StartUpFireFox.ini, options, autorun
	IniRead, startup, StartUpFireFox.ini, options, startup
	IniRead, saveas, StartUpFireFox.ini, options, saveas
	IniRead, debug, StartUpFireFox.ini, options, debug

;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	menu, tray, add
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh %mode%, doReload				; Reload the script.
	Menu, Tray, Icon, Refresh %mode%, %icofolder%\ico_reboot.ico, 1
	menu, tray, add
	menu, tray, add, --= Options =--, about
	Menu, tray, Disable, --= Options =--
	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	;Menu, tray, icon, Autorun On/Off = %autorun%, %icofolder%\ico_options.ico
	Menu, tray, add, AutoMouse On/Off = %saveas%, automouse			; auto move mouse
	;Menu, tray, icon, AutoMouse On/Off = %saveas%, %icofolder%\ico_options.ico
	menu, tray, add, Start Delay = %delay%, startdelay
	;menu, tray, icon, Start Delay = %delay%, %icofolder%\ico_options.ico
	Menu, tray, add, Open StartUpFireFox.ini, openini
	;Menu, tray, icon, Open StartUpFireFox.ini, %icofolder%\ico_options.ico
	menu, tray, add
	Menu, tray, add, Firefox Close, close					; Close ff
	Menu, Tray, Icon, Firefox Close, %icofolder%\ico_shut.ico, 1
	Menu, tray, add, Minimize, minimize
	Menu, Tray, Icon, Minimize, %icofolder%\ico_minimize.ico, 1
	Menu, tray, add, Maximize, maximize
	Menu, Tray, Icon, Maximize, %icofolder%\ico_Maximize.ico, 1
	menu, tray, add
	Menu, tray, add, Start Blank Pages, traystartblank			; Start new ff
	Menu, Tray, Icon, Start Blank Pages, %icofolder%\ico_FF_red.ico, 1
	Menu, tray, add, Start/Open Firefox (Same as click), traystart				; Start new ff
	menu, tray, Default, Start/Open Firefox (Same as click)
	Menu, Tray, Icon, Start/Open Firefox (Same as click), %icofolder%\ico_FF_red.ico, 1
	menu, tray, add
	Menu, Tray, Tip, %title%

;;--- Software start here ---

loop:

	Menu, Tray, Icon, %icofolder%\ico_ff_blue.ico

IfExist, %path%, Goto, Start
	MsgBox, Firefox is not installed in %path%.
	ExitApp

start:
	IfWinExist, Mozilla Firefox
		{
		goto, maximize
		}
	goto, run
	msgbox, Error to detect if Firefox is running already!
	ExitApp

Run:
	IfEqual, autorun, 0, goto, wait
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip	; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	;;msgbox, startup=%startup%
	Run, %path% %startup%
	Sleep, 1000
	WinWait, Mozilla Firefox
	Sleep, 2000
	IfEqual, minimize, 1, goto, minimize
	IfEqual, Maximize, 1, goto, Maximize
	msgbox, Error (variable?) StartUpFireFox.ini
	Goto, wait

traystartblank:
	Menu, Tray, Icon, %icofolder%\ico_ff_blue.ico
	SetEnv, startup, about:blank
	Goto, skip2

traystart:
	Menu, Tray, Icon, %icofolder%\ico_ff_blue.ico
	IniRead, startup, StartUpFireFox.ini, options, startup
	skip2:
	IfWinExist, Mozilla Firefox
		{
		goto, existmax
		}
	Run, %path% %startup%
	Sleep, 1000
	WinWait,- Mozilla Firefox
	Sleep, 1000
	existmax:
	Menu, Tray, Icon, %icofolder%\ico_ff_red.ico		;; added on 2021-02-04
	WinActivate, Mozilla Firefox
	Sleep, 1000
	;WinMaximize, Mozilla Firefox
	WinShow, Mozilla Firefox
	Goto, wait

minimize:
	Menu, Tray, Icon, %icofolder%\ico_ff_blue.ico
	Sleep, 1000
	WinMinimize,Mozilla Firefox
	Goto, wait

maximize:
	Menu, Tray, Icon, %icofolder%\ico_ff_blue.ico
	Sleep, 1000
	WinActivate, Mozilla Firefox
	Sleep, 1000
	;WinMaximize, Mozilla Firefox
	Goto, wait

wait:
	Menu, Tray, Icon, %icofolder%\ico_ff_red.ico
	IfEqual, saveas, 0, goto, waitingloop

	WinWaitActive, Save Image
	; WinWaitActive, Save, &Enregistrer

	CoordMode, Mouse, Relative
	;CoordMode, Mouse, Screen
	MouseGetPos, InVarX, InVarY

	;; WinWaitActive, Save
	Menu, Tray, Icon, %icofolder%\ico_Save.ico
	WinMove, Save Image, , , ,850,550	; It grab only images files , causes some bugs with anotherS softwares.
	; WinMove, Save As, , , ,850,550
	MouseMove, 675, 520, 5
	AnyKeyWait() {				; mouse move count
		T := A_TimeIdle
		Loop {
		If (A_TimeIdle - T < 0)
		Break
		}
		}
	WinWaitActive, Mozilla Firefox		; wait saveas dissapear
	IfEqual, Debug, 1, MsgBox, MouseMove %InVarX% %InVarY%
	MouseMove, %InVarX%, %InVarY%, 2
	Menu, Tray, Icon, %icofolder%\ico_ff_red.ico
	goto, wait


automouse:
	SetEnv, oldsaveas, %saveas%
	IfEqual, saveas, 1, goto, deactivemouse
	goto, activemove

	activemove:
		SetEnv, saveas, 1
		IniWrite, 1, StartUpFireFox.ini, options, saveas
		TrayTip, MoveMouse, Activated, 2, 1
		Menu, Tray, Rename, AutoMouse On/Off = %oldsaveas%, AutoMouse On/Off = %saveas%
		goto, wait

	deactivemouse:
		SetEnv, saveas, 0
		IniWrite, 0, StartUpFireFox.ini, options, saveas
		TrayTip, MoveMouse, Deactivated, 2, 1
		Menu, Tray, Rename, AutoMouse On/Off = %oldsaveas%, AutoMouse On/Off = %saveas%
		goto, waitingloop

waitingloop:
	Menu, Tray, Icon, %icofolder%\ico_FF_red.ico
	sleep, 2147483647			; 24 days
	goto, waitingloop

openini:
	run, notepad.exe "StartUpFireFox.ini"
	return

startdelay:
	IniRead, delay, StartUpFireFox.ini, options, delay
	SetENv, olddelay, %delay%
	InputBox, newdelay, StartUpFireFox, Set new timer start in seconds ? Now time is %delay% sec. Set between 1 and 240 seconds
		if ErrorLevel
			goto, wait
	IniWrite, %newdelay%, StartUpFireFox.ini, options, delay
	;; msgbox, old=%olddelay% ... new=%newdelay%
	IfGreater, newdelay, 240, Goto, startdelay
	IfLess, newdelay, 1, Goto, startdelay
	Menu, Tray, Rename, Start Delay = %olddelay%, Start Delay = %newdelay%
	goto, wait

autorunonoff:
	SetEnv, oldautorunonoff, %autorunonoff%
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_02 autorun error variable must be 1 or 0
	Menu, Tray, Icon, %icofolder%\ico_FF_red.ico
	Goto, wait

	enableautorun:
	IniWrite, 1, StartUpFireFox.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, %icofolder%\ico_FF_red.ico
	Goto, wait

	disableautorun:
	IniWrite, 0, StartUpFireFox.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
	Menu, Tray, Icon, %icofolder%\ico_FF_red.ico
	Goto, wait

;;--- Quit (escape , esc) ---

exitapp:
	ExitApp

;Escape::		; For debug & testing
	ExitApp

doReload:
	Reload
	Return

;;--- Tray Bar (must be at end of file) ---

Secret:
	Menu, Tray, Icon, %icofolder%\ico_secret.ico
	IniRead, startup, StartUpFireFox.ini, options, startup
	MsgBox, 0, Start Up Firefox Secret ALL variables show, A_WorkingDir=%A_WorkingDir% path=%path%`n`ndelay=%delay% saveas=%saveas% maximize=%maximize% minimize=%minimize% autorun=%autorun%`n`nstartup=%startup%
	Menu, Tray, Icon, %icofolder%\ico_FF_red.ico
	Return

close:
	WinClose, Mozilla Firefox
	Return

about:
	TrayTip, %title%, %mode% by %author%, 2, 1
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull to strat Firefox with delay.`n`n`tGo to https://github.com/LostByteSoft
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---   