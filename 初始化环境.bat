@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   fanyi - 双语论文工具环境初始化
echo ========================================
echo.

where python >nul 2>nul
if errorlevel 1 (
  echo [错误] 未找到 Python。
  echo 请安装 Python 3.10 或更高版本，并勾选 Add Python to PATH。
  pause
  exit /b 1
)

echo [1/4] 检查 Git 子模块...
git submodule update --init --recursive
if errorlevel 1 (
  echo [错误] Git 子模块初始化失败。
  pause
  exit /b 1
)

echo [2/4] 创建 Bilingual-Paper-Reader 虚拟环境...
if not exist "bilingual-paper-reader\.venv\Scripts\python.exe" (
  python -m venv "bilingual-paper-reader\.venv"
  if errorlevel 1 (
    echo [错误] 虚拟环境创建失败。
    pause
    exit /b 1
  )
)

echo [3/4] 安装 Bilingual-Paper-Reader...
"bilingual-paper-reader\.venv\Scripts\python.exe" -m pip install --upgrade pip
"bilingual-paper-reader\.venv\Scripts\python.exe" -m pip install -e "bilingual-paper-reader"
if errorlevel 1 (
  echo [错误] Python 依赖安装失败。
  pause
  exit /b 1
)

echo [4/4] 准备配置文件...
if not exist "bilingual-paper-reader\.env" (
  copy /Y "bilingual-paper-reader\.env.example" "bilingual-paper-reader\.env" >nul
  echo 已创建 bilingual-paper-reader\.env，请填入 MINERU_TOKEN 和模型 API 配置。
) else (
  echo 已存在 bilingual-paper-reader\.env，跳过覆盖。
)

echo.
echo ========================================
echo 初始化完成。
echo 下一步：
echo 1. 编辑 bilingual-paper-reader\.env
echo 2. 填写 MINERU_TOKEN
echo 3. 填写 OPENROUTER_API_KEY 等模型配置
echo 4. 双击 启动逐句双语翻译.bat
echo ========================================
pause
