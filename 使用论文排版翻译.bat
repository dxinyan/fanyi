@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   translate-academic-paper
echo   学术论文中英对照排版工作流
echo ========================================
echo.
echo 此工具不是独立桌面软件，而是给能操作本地文件的 AI Agent 使用的 Skill。
echo 请使用 Codex CLI、Claude Code、Gemini CLI、Cursor、Cline、Aider 等。
echo.
echo 如果把 PDF 拖到本窗口，下面会先执行 PDF 检查：
echo.

if "%~1"=="" (
  echo 用法：把 PDF 文件拖到本 bat 文件上。
  echo.
  echo 推荐交给 AI Agent 的提示词：
  echo 请读取 translate-academic-paper\SKILL.md 和 references\runbook.md，
  echo 严格按流程把这个 PDF 翻译成中英对照 HTML，并执行每章 QA。
  echo.
  pause
  exit /b 0
)

set "PDF=%~1"
if not exist "%PDF%" (
  echo [错误] 找不到 PDF：%PDF%
  pause
  exit /b 1
)

where python >nul 2>nul
if errorlevel 1 (
  echo [错误] 未找到 Python 3.10+。
  pause
  exit /b 1
)

cd /d "%~dp0translate-academic-paper"
python -m pip install pymupdf pillow
python scripts/inspect_pdf.py "%PDF%"

echo.
echo 检查完成。接下来请让你的 AI Agent 读取：
echo   SKILL.md
echo   references\runbook.md
echo 并继续完整翻译流程。
pause
