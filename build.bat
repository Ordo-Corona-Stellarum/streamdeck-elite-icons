@echo off
:: Stream Deck Elite Tintable Language-Neutral Icon Pack

setlocal EnableExtensions EnableDelayedExpansion

set theme_name=%~1
set normal_color=%~2
set active_color=%~3
set disabled_color=%~4
set alarm_color=%~5

echo Building Stream Deck Elite Icon Set %theme_name%

if "%alarm_color%" == "" echo Invalid arguments && exit /b

rmdir /s /q "%theme_name%"
mkdir "%theme_name%"

for %%s in (icons\*.svg) do (
    set "svg=%%s"
    set "basename=%%~ns"
    echo Generating !basename! icons

    set "normalpng=!basename!-normal.png"
    set "activepng=!basename!-active.png"
    set "disabledpng=!basename!-disabled.png"
    set "alarmpng=!basename!-alarm.png"

    magick !svg! -transparent white xc:"%normal_color%" -channel RGB -clut "%theme_name%\!normalpng!" || exit /B
    magick !svg! -transparent white xc:"%active_color%" -channel RGB -clut "%theme_name%\!activepng!" || exit /B
    magick !svg! -transparent white xc:"%disabled_color%" -channel RGB -clut "%theme_name%\!disabledpng!" || exit /B
    magick !svg! -transparent white xc:"%alarm_color%" -channel RGB -clut "%theme_name%\!alarmpng!" || exit /B
)

magick montage -tile "10x" -background "#101010" -geometry "64x64+0+0" "%theme_name%\*-normal.png" "images\%theme_name%.png"
