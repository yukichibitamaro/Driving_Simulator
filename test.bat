@echo off
setlocal enabledelayedexpansion

:: Git�n�b�V������������擾
set "commit_hash=38a5190e017af9e58724d3a5d5e9532d7661983b"

:: git show�R�}���h�ŏ����擾
for /f "tokens=1-3 delims=," %%a in ('git show -s --format=%%cd,%%cn,%%s %commit_hash% --date=format:"%%Y%%m%%d"') do (
    set "push_date=%%a"
    set "pusher=%%b"
    set "commit_message=%%c"
)

:: JSON�`���Ńt�@�C���ɏo��
(
echo {
echo   "push_date": "!push_date!",
echo   "pusher": "!pusher!",
echo   "commit_message": "!commit_message!"
echo }
) > commit_info.json

endlocal

pause
