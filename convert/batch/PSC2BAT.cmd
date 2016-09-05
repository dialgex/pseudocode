REM .########...######..########.##.....##.########...#######...######...#######..########..########
REM .##.....##.##....##.##.......##.....##.##.....##.##.....##.##....##.##.....##.##.....##.##......
REM .##.....##.##.......##.......##.....##.##.....##.##.....##.##.......##.....##.##.....##.##......
REM .########...######..######...##.....##.##.....##.##.....##.##.......##.....##.##.....##.######..
REM .##..............##.##.......##.....##.##.....##.##.....##.##.......##.....##.##.....##.##......
REM .##........##....##.##.......##.....##.##.....##.##.....##.##....##.##.....##.##.....##.##......
REM .##.........######..########..#######..########...#######...######...#######..########..########
REM ..................................########..#######.                                            
REM .....................................##....##.....##                                            
REM .....................................##....##.....##                                            
REM .....................................##....##.....##                                            
REM .....................................##....##.....##                                            
REM .....................................##....##.....##                                            
REM .....................................##.....#######.                                            
REM ......................########.....###....########..######..##.....##                           
REM ......................##.....##...##.##......##....##....##.##.....##                           
REM ......................##.....##..##...##.....##....##.......##.....##                           
REM ......................########..##.....##....##....##.......#########                           
REM ......................##.....##.#########....##....##.......##.....##                           
REM ......................##.....##.##.....##....##....##....##.##.....##                           
REM ......................########..##.....##....##.....######..##.....##                           
REM 
::@echo off
Setlocal EnableDelayedExpansion
cls

:Set_vars
set PSC_dir="Put_files_here"
set cmd_input=%*
:Set_vars_end

call :Title

:Dir_check
if not exist %PSC_dir% (
	mkdir %PSC_dir%
	call :First_time_run
	pause
	exit /b 1
)
:Dir_check_end


:CMD_Input_Check
echo.
echo 		Input check
if not "%*"=="" (
	echo 	Input found: %*
	call :Flag_check %*
	if not "%errorlevel%"=="0" goto :errbreak
)
echo 	Input check complete
pause
:CMD_Input_Check_End


:Main_menu
echo.
echo 	[1] 	- Convert all PSC files in folder to BAT
echo 	[2] 	- Convert a specific PSC file to BAT
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[9] 	- Program information
echo.

choice /n /c 129 /m "[----->  "

if %errorlevel% == 9 goto:Information
if %errorlevel% == 2 goto:Specific_convert
if %errorlevel% == 1 goto:Multiple_convert
goto:eof
:Main_menu_end


:PSC_check
echo.
echo 	PSC check
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
exit /b 0
:PSC_check_end

:Flag_check
echo.
echo 		Flag check
for /f "tokens=1,2" %%a in ("%*") do (
	set flag = %%a
	set parm = %%b
	if /i "!flag!"=="/s" (
		echo 	Single Convert
		if not "!parm:~-4!"==".psc" (
			call :Flag_error_1
			exit /b 11
		) else (
			echo 	File ext match
			pause
		)
	) else if /i "%%a"=="/m" (
		echo 	Multiple Convert
	)
)
if not "%errorlevel%"=="0" exit /b & exit /b %errorlevel%
exit /b 0
:Flag_check_end

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

REM THIS SECTION IS PURELY FOR DEBUGGING PURPOSES

:debug
:debug_end

REM EVERYTHING BELOW THIS POINT IS DEDICATED TO ECHO DISPLAYS

:Title_display
:Title
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
goto:eof
:Title_end
:Title_display_end



:Error_displays
:Flag_error_1
echo.
echo.
echo  [^^!] ERROR: 	Input file does not end in .PSC
		echo 		Please rerun with proper parameters
echo.
echo.
echo.
echo  [^^!] ERRCODE: 		FLG01
echo.
goto:eof
:Flag_error_1_end


:First_time_run
echo.
echo.
echo 	[^^!] ERROR: 	First-time run!
echo 	
echo 	[^^!] Please run again with files in their appropriate folders.
echo.
goto:eof
:First_time_run_end
:Error_displays_end

:errbreak
echo PROGRAM ABENDED DUE TO ERROR(S)
pause
