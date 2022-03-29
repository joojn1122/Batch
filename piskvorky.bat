:: disable showing the path 
@echo off
:: for variables which are in for or if
setlocal enabledelayedexpansion
:: title
title Piskvorky

set numList = ""
set displayList = ""

:: generates random number between 1 - 2
set /a player=%RANDOM% * 2 / 32768 + 1

:gameloop

:: swap players
if "%player%"=="1" (
	set player=2
) else if "%player%"=="2" (
	set player=1
)

:inputloop
set /p num="Player %player%> "


:: if exit
IF "%num%"=="exit" (
	echo Tie.
	call :exit
	exit /b
)

:: if number is > 9
IF %num% gtr 9 (
	echo Invalid number!
	goto inputloop
)
:: if number is < 1
IF %num% lss 1 (
	echo Invalid number!
	goto inputloop
)
:: if num already in list
for %%a in (%numList%) do (
   if "%%a"=="%num%" (
   		echo This slot is not empty!
   		goto inputloop
   )
)

set numList=%numList% %num%

if %player%==1 (
	set displayList=%displayList% X
) else (
	set displayList=%displayList% O
)


call :drawDesk

goto gameloop

call :exit
exit /b

:drawDesk
	echo | set /p dummyName="| "

	:: set element
	set i=0
	for %%i in (%displayList%) do (
		set /a i+=1
		set element[!i!]=%%i
	)

	for /l %%x in (1, 1, 9) do (
		set char=-
		set i=0
		for %%a in (%numList%) do (
			set /a i+=1
		  	if "%%a"=="%%x" (
		   		set char=!element[1]!
		   		echo.
		   		echo.
		   		echo !char!
		   		echo %displayList%
		   		echo %numList%
		   		echo.
		   		echo.
		   	)
		)

		echo | set /p dummyName="!char! "

		:: if num > 2 && num < 4
		if %%x gtr 2 (
			if %%x lss 4 (
				echo | set /p dummyName="|"
				echo.
				echo | set /p dummyName="| "
			)
		)

		:: if num > 5 && num < 7
		if %%x gtr 5 (
			if %%x lss 7 (
				echo | set /p dummyName="|"
				echo.
				echo | set /p dummyName="| "
			)
		)
	)

	:: escaping illegal chars	
	echo | set /p dummyName="|"
	echo.

	exit /b

:exit
	:: clear all variables
	set "player="
	set "numList="
	set "num="
	set "dummyName="
	set "i="
	set "char="
	set "element="

	exit /b
