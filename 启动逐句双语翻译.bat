@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

if not exist "bilingual-paper-reader\.venv\Scripts\python.exe" (
  echo 尚未初始化环境，先运行 初始化环境.bat
  pause
  exit /b 1
)

if not exist "bilingual-paper-reader\.env" (
  echo 未找到配置文件 bilingual-paper-reader\.env
  echo 请先运行 初始化环境.bat
  pause
  exit /b 1
)

echo 正在启动 Bilingual Paper Reader...
echo 浏览器地址：http://127.0.0.1:8000
echo 关闭此窗口即可停止服务。
echo.

start "" http://127.0.0.1:8000
cd /d "%~dp0bilingual-paper-reader"
".venv\Scripts\python.exe" -m app.main
