@echo off
setlocal EnableDelayedExpansion

set quiet=^> NUL 2^>^&1
set fullpath=%~dp0

python %fullpath%\gitcheck.py
