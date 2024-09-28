@echo off
setlocal enabledelayedexpansion

:: Gitハッシュを引数から取得
set "commit_hash=38a5190e017af9e58724d3a5d5e9532d7661983b"

:: git showコマンドで情報を取得
for /f "tokens=1-3 delims=," %%a in ('git show -s --format=%%cd,%%cn,%%s %commit_hash% --date=format:"%%Y%%m%%d"') do (
    set "push_date=%%a"
    set "pusher=%%b"
    set "commit_message=%%c"
)

:: JSON形式でファイルに出力
(
echo {
echo   "push_date": "!push_date!",
echo   "pusher": "!pusher!",
echo   "commit_message": "!commit_message!"
echo }
) > commit_info.json

endlocal

pause
