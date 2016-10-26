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
REM ################################################################################################
REM ###>--------<######>--------<######>--------<######>--------<######>--------<######>--------<###
REM ################################################################################################
:Pre_startup
:Set_environment_settings
@echo off
setlocal enabledelayedexpansion
chcp 1252
mode 75, 30
color f3
title PSC 2 BAT - Conversion Utility ^|-^| © DeltaZed (Dialgex) - 2016
:Set_environment_settings_end
:Pre_startup_end
REM ################
REM ################
REM ################
:Startup
cls
call :Title
echo 		Beginning Startup
:Set_vars
echo.
echo 		Setting Variables
set local_dir=%~dp0
set local_dir=!local_dir:~0,-1!
set psc_dir=%local_dir%\Put_files_here
set cmd_input=%*
echo 		Variables Set
:Set_vars_end
:Dir_check
echo.
echo 		Checking if directory exists
if not exist %psc_dir% (
	mkdir %psc_dir%
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
choice /n /c 12-0
if "%errorlevel%"=="4" (
	cls
	call :Title
	call :Information
	pause
) && goto :Program_start
if "%errorlevel%"=="3" goto:Debug_menu
if "%errorlevel%"=="2" goto:Specific_menu
if "%errorlevel%"=="1" goto:Multiple_menu
goto:errbreak
:Main_menu_end
:Multiple_menu
cls
call :Title
call :Multiple_menu_display
choice /n /c 12340
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
choice /n /c 12340
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
if exist %psc_dir%\%file% (
	echo 			File found here:
	echo 		\%psc_dir%\%file%
	echo.
	echo. 	Is this the correct file? [Y/N]
	choice /n /c yn
) else if exist %file% (
	echo 		File found in base directory:
	echo 			\%file%
	echo.
	echo. 	Is this the correct file? [Y/N]
	choice /n /c yn
) else call :Input_error_2

pause
endlocal
goto:Specific_menu
goto:errbreak
:Single_by_name_end
:Single_from_list
cls
call :Title
setlocal
set index_count=1
set index_count_tens=0
set page=0
@echo on
for /r %%a in (.\*) do (
	set file=%%~nxa
	set dir=%%~dpa
	if "!index_count:~-1!"=="0" if not "!index_count:~0,1!"=="0" (
		set /a index_count+=1
		set /a index_count_tens+=1
	)
	if /i "!file:~-4!"==".psc" if not "!dir!"=="%psc_dir%\" (
		set file_index[!index_count!]=!file!
		echo !index_count!
	call :Expand_variable file_index[ !index_count! ]
	echo !return!
		set /a index_count+=1
	) else if /i "!file:~-4!"==".psc" if "!dir!"=="%psc_dir%\" (
		for %%g in (%psc_dir%\.) do set curr_dir=%%~nxg
		set file_index[!index_count!]=!curr_dir!\!file!
		echo !index_count!
	call :Expand_variable file_index[ !index_count! ]
	echo !return!
		set /a index_count+=1
	)
	pause
)
set /a index_count-=1
for /l %%a in (1,1,9) do (
	if "%page%"=="0" (
		set entry_num=%%a
	) else (
		set entry_num=!page!%%a
	)
	call :Expand_variable file_index[ !entry_num! ]
	set entry=!return!
	echo 	[%%a] [!entry_num!]	!entry!
)
if "%index_count_tens%" gtr "0" (
	if "%page%" equ "0" (
		echo 				[^>] - Next page
	) else if "%page%" equ "%index_count_tens%" (
		echo 	[^<] - Previous page
	) else if "%page%" lss "%index_count_tens%" (
		echo 	[^<] - Previous page	[^>] - Next page
	)
) 




@echo off






pause
endlocal
goto:Specific_menu
goto:errbreak
:Single_from_list_end
































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
		if not exist %psc_dir%\!parm! (
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

:Specific_list
setlocal
set number=%1
set file=%2
set specific_%1=%2
echo 	[%number%] - %file%
endlocal
goto:eof
:Specific_list_end

:Expand_variable
setlocal EnableDelayedExpansion
set var1=%1
set var2=%2
set var3=%3
set pre_expnd=%var1%%var2%%var3%
set expnd=%!pre_expnd!%
endlocal & set return=%expnd%
goto:eof
:Expand_variable_end

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
:Debug_menu
cls
call :Title
call :Debug_menu_display
choice /n /c 10
if "%errorlevel%"=="2" goto:Main_menu
if "%errorlevel%"=="1" goto:Debug_function_menu
goto:errbreak
:Debug_menu_end
:Debug_function_menu
cls
call :Title
call :Debug_function_menu_display
choice /n /c 10
if "%errorlevel%"=="2" goto:Main_menu
if "%errorlevel%"=="1" goto:Debug_Expand_Variable
goto:errbreak
:Debug_function_menu_end

:Debug_Expand_Variable
cls
call :Title
setlocal
set /p "bugVar1=Name the variable: "
set /p "bugVar2=Name the value: "
pause
endlocal
goto:Debug_function_menu
:Debug_Expand_Variable_end
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
echo 	[-] 	- Debug Menu
echo 	[0] 	- Program information
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
echo.
echo 	[0] 	[0] 	- Go back
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
echo.
echo 	[0] 	[0] 	- Go back
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
:Debug_menu_display
echo.
echo 		[==========]  DEBUG MENU  [==========]
echo.
echo 	[1] 	- Test a function
echo 	[2] 	- TBD
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[0] 	- Back
echo.
goto:eof
:Debug_menu_display_end
:Debug_function_menu_display
echo.
echo 		[==========]  DEBUG MENU  [==========]
echo.
echo 	[1] 	- Variable Expansion
echo 	[2] 	- TBD
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo 	[0] 	- Back
echo.
goto:eof
:Debug_function_menu_display_end
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
