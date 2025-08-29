:: Youtube-dl
:: ---------------
:: wrapper script to download videos.

:: Requirements
:: ----
:: https://github.com/yt-dlp/yt-dlp
::

@echo off
setlocal EnableDelayedExpansion

set fullpath=%~dp0
set videourl=%~1
set playlist=%~2
set path_ffmpeg="C:\Toolchain\ffmpeg\5.1\bin\ffmpeg.exe"
set path_download="%USERPROFILE%\Downloads\youtube"

if not "%playlist%"=="" (
  set download=%videourl%=%playlist%
) else (
  set download=%videourl%
)

set arguments= ^
  --ignore-errors ^
  --yes-playlist ^
  --no-check-certificate ^
  --format "bestvideo[height<=1080][ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/best[ext=mp4]/best" ^
  --ffmpeg-location %path_ffmpeg% ^
  -P %path_download% ^
  -o "%%(uploader)s\%%(playlist|Others)s\%%(title)s.%%(ext)s"

cd %fullpath%\..
echo Downloading: %download%
echo.

yt-dlp.exe !arguments! "%download%"
