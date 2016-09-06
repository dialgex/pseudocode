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
REM ################################
REM ###>--------<######>--------<###
REM ################################
:Startup
:Set_environment_settings
@echo off
setlocal enabledelayedexpansion
chcp 1252
title PSC 2 BAT - Conversion Utility ^|-^| © DeltaZed (Dialgex) - 2016
:Set_environment_settings_end
cls
call :Title
echo 		Beginning Startup
:Set_vars
echo.
echo 		Setting Variables
set File_dir="Put_files_here"
set cmd_input=%*
echo 		Variables Set
:Set_vars_end
:Dir_check
echo.
echo 		Checking if directory exists
if not exist %File_dir% (
	mkdir %File_dir%
	call :First_time_run
	pause
	exit /b 1
)
echo 		Check passed
:Dir_check_end
:CMD_Input_Check
echo.
echo 		Input check
if not "%*"=="" (
	echo 	Input found: %*
	call :Flag_check %*
	if not "!errorlevel!"=="0" goto :errbreak
)
echo 		Input check complete
:CMD_Input_Check_End
echo.
echo 		Startup complete
:Startup_end

REM ################################
REM ###>--------<######>--------<###
REM ################################

:Program_start
:Main_menu
cls
call :Title
call :Main_menu_display
choice /n /c 129
if "%errorlevel%"=="3" (
	cls
	call :Title
	call :Information
	pause
) && goto :Program_start
if "%errorlevel%"=="2" goto:Specific_menu
if "%errorlevel%"=="1" goto:Multiple_menu
goto:errbreak
:Main_menu_end
:Multiple_menu
cls
call :Title
call :Multiple_menu_display
choice /n /c 12349
if "%errorlevel%"=="5" goto:Main_menu
if "%errorlevel%"=="4" goto:Main_menu
if "%errorlevel%"=="3" goto:Multiple_from_list
if "%errorlevel%"=="2" goto:Multiple_by_name
if "%errorlevel%"=="1" goto:All_from_folder
goto:errbreak
:Multiple_menu_end
:Specific_menu
cls
call :Title
call :Specific_menu_display
choice /n /c 12349
if "%errorlevel%"=="5" goto:Main_menu
if "%errorlevel%"=="4" goto:Main_menu
if "%errorlevel%"=="3" goto:Main_menu
if "%errorlevel%"=="2" goto:Single_from_list
if "%errorlevel%"=="1" goto:Single_by_name
goto:errbreak
:Specific_menu_end

:All_from_folder
goto:errbreak
:All_from_folder_end
:Multiple_by_name
goto:errbreak
:Multiple_by_name_end
:Multiple_from_list
goto:errbreak
:Multiple_from_list_end
:Single_by_name
setlocal
cls
call :Title
call :Specific_by_name_display_1
set /p file=
if not exist %file% (
	call :Input_error_2
)
call :Dictionary !psc_in!
call :Specific_by_name_display_2
pause
endlocal
goto:Specific_menu
goto:errbreak
:Single_by_name_end
:Single_from_list
goto:errbreak
:Single_from_list_end













:PSC_check
echo.
echo 	PSC check
SETLOCAL
for %%a in (%File_dir%\*) do (
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
















REM ################################
REM 	FUNCTIONS			Sec3
REM ################################

:Flag_check
echo.
echo 		Flag check
setlocal
for /f "tokens=1,2" %%a in ("%*") do (
	set flag=%%a
	set parm=%%b
	if /i "!flag!"=="/s" (
		echo 	Single Convert
		if /i not "!parm:~-4!"==".psc" (
			call :Input_error_1
			exit /b 10
		)
		if not exist %File_dir%\!parm! (
			call :Input_error_2
			exit /b 11
		)
		echo 	File match
		pause
	) else if /i "%%a"=="/m" (
		echo 	Multiple Convert
	)
)
endlocal
echo 		Flag check complete
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

REM ################
REM THIS SECTION IS PURELY FOR DEBUGGING PURPOSES
REM ################

:debug
:debug_end

REM ################
REM EVERYTHING BELOW THIS POINT IS DEDICATED TO ECHO DISPLAYS
REM ################

:Program_displays
REM ###>--------<###
:Title
cls
echo.
echo.
echo 		[====================================]
echo.
echo 			Pseudocode to Batch
echo 			Conversion Utility
echo.
echo 		     © Delta Zed (Dialgex) - 2016
echo 		[====================================]
echo.
echo.
goto:eof
:Title_end
:Main_menu_display
echo.
echo 		[==========]  MAIN MENU  [===========]
echo.
echo 	[1] 	- Convert multiple PSC files to BAT
echo 	[2] 	- Convert a specific PSC file to BAT
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[9] 	- Program information
echo.
goto:eof
:Main_menu_display_end
:Multiple_menu_display
echo.
echo 		[=====] CONVERT MULTIPLE FILES [=====]
echo.
echo 	[1] ^<	[1] 	- Convert all PSC files in the folder
echo 	[2] 	[2] 	- Convert specific PSC files by name
	echo 		[3] 	- Convert specific PSC files from a list
	echo 		[4] 	- 
echo.
echo.
echo.
echo.
echo 	[9] 	[9] 	- Go back
echo.
goto:eof
:Multiple_menu_display_end
:Specific_menu_display
echo.
echo 		[====] CONVERT A SPECIFIC FILE [=====]
echo.
echo 	[1] 	[1] 	- Convert a file by name
echo 	[2] ^<	[2] 	- Convert a file from a list
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[9] 	[9] 	- Go back
echo.
goto:eof
:Specific_menu_display_end
:Specific_by_name_display_1
echo.
echo 		[====] CONVERT A SPECIFIC FILE [=====]
echo.
echo 	[1] ^< 	Please enter the filename:
echo 	[2] 	
goto:eof
:Specific_by_name_display_1_end
:Specific_by_name_display_2
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[9] 	[9] 	- Go back
echo.
goto:eof
:Specific_by_name_display_2_end
:Information
echo 		COMING SOON
goto:eof
:Information_end
REM ###>--------<###
:Program_displays_end


:Error_displays
REM ###>--------<###
:Input_error_1
echo.
echo.
echo  [^^!] ERROR: 	Input file does not end in .PSC
		echo 		Please rerun with proper parameters
echo.
echo.
echo.
echo  [^^!] ERRCODE: 		INP01
echo.
goto:eof
:Input_error_1_end
:Input_error_2
echo.
echo.
echo  [^^!] ERROR: 	Input file cannot be found
		echo 		Please rerun with proper parameters
echo.
echo.
echo.
echo  [^^!] ERRCODE: 		INP02
echo.
goto:eof
:Input_error_2_end
:First_time_run
echo.
echo.
echo 	[^^!] ERROR: 	First-time run!
echo.
echo 	[^^!] Please run again with files in their appropriate folders.
echo.
goto:eof
:First_time_run_end
REM ###>--------<###
:Error_displays_end

REM ################
REM END OF FILE
REM ################

:errbreak
echo  [^<^>] 	PROGRAM ABENDED DUE TO ERROR(S) (It's not done yet)
echo.
pause
