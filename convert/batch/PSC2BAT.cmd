@echo off
Setlocal EnableDelayedExpansion
cls

:Set_vars
set PSC_dir="Put_files_here"
set cmd_input=%*
:Set_vars_end

:title
cls
echo.
echo.
echo 		[====================================]
echo.
echo 			Pseudocode to Batch
echo 			Conversion Utility
echo.
echo 			© Dialgex - 2016
echo 		[====================================]
echo.
echo.
:title_end

:dir_check
if not exist %PSC_dir% (
	mkdir %PSC_dir%
	echo.
	echo 	[^!] First-time run!
	echo.
	echo.
	echo.
	echo 	[^!] Please run again with files in their appropriate folders.
	echo.
	pause
	goto:eof
)
:dir_check_end


:CMD_Input_Check
if not "%cmd_input%"=="" (
	echo 	Input found
	echo 	%cmd_input%
	call :Dictionary %cmd_input%
	pause
)
:CMD_Input_Check_End


:Main_menu
echo.
echo 	[1] 	- Convert all PSC files to BAT
echo.
echo 	[3] 	- Program information
echo.

choice /n /c 13 /m "[----->  "

if %errorlevel% == 2 goto:Information
if %errorlevel% == 1 goto:PSC_check
goto:eof
:Main_menu_end


:PSC_check
echo PSC_check
SETLOCAL
for %%a in (%PSC_dir%\*) do (
	set psc_in=%%a
	if "!psc_in!"=="" (
		echo Directory empty
		pause
		goto:Title
	) else call :Dictionary !psc_in!
)
ENDLOCAL
goto:eof
:PSC_check_end


:Dictionary
for /f "tokens=*" %%b in (%1) do (
	set check_line=%%b
	for /f "tokens=1-3" %%c in ("!check_line!") do (
		set check_string=%%c
		if "!check_string:~0,1!"=="$" (
			echo Found Variable %%c
			if "%%d"=="=" (
				set !check_string:$=! = %%e
				echo !check_string:$=!
			)
		)
	)
)
goto:eof
:Dictionary_end
pause
goto:eof