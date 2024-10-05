@echo off

set COMMIT_HASH=0cab1d63f989bd67c7c0a3c2a72f64a282e76040


REM git show コマンドで情報を取得し、一時ファイルに保存
for /f "tokens=*" %%i in ('git show %COMMIT_HASH% --pretty^="format:%%h:%%an:%%ad:%%s" --date=iso --no-patch') do set GIT_INFO=%%i 


REM コロンで区切られた情報を変数に分割
for /f "tokens=1,2,3,* delims=:" %%a in ("%GIT_INFO%") do (
    set COMMIT_HASH_SHORT=%%a
    set AUTHOR_NAME=%%b
    set FULL_DATE=%%c
    set MESSAGE=%%d
)


REM コミットメッセージの成形(コロンで分割し、最後の部分を抽出する処理を2回繰り返す)

REM コロンで分割し、最後の部分を抽出(1回目)
for /f "tokens=1,* delims=:" %%m in ("%MESSAGE%") do (
    set "temp=%%n"
)
REM コロンで分割し、最後の部分を抽出(2回目)
for /f "tokens=1,* delims=:" %%m in ("%temp%") do (
    set "MESSAGE=%%n"
)


REM push日の成形(YYYY-MM-DD HH:MM:SS を YYYYMMDD に変換)
set DATE=%FULL_DATE:~0,4%%FULL_DATE:~5,2%%FULL_DATE:~8,2%


REM JSON形式でファイルに出力
(
    echo {
    echo   "commit_hash": "%COMMIT_HASH_SHORT%",
    echo   "author": "%AUTHOR_NAME%",
    echo   "date": "%DATE%",
    echo   "message": "%MESSAGE%"
    echo }
) > commit_info.json

REM 終了メッセージ
echo Commit information saved to commit_info.json

endlocal
pause
