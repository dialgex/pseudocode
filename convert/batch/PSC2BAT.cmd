@echo off
cls

:Set_vars
set PSC_dir=".\Put .psc files here"
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

:Main_menu
echo.
echo 	[1] 	- Convert all PSC files to BAT
echo.
echo 	[3] 	- Program information
echo.

choice /n /c 13 /m "[----->  "
:Main_menu_end

:PSC_file_check

:PSC_file_check_end

pause
goto:eof