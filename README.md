# fanyi —— 双语论文翻译工具集

这个仓库把两种不同定位的论文翻译工具整理到一起：

- **逐句双语精读**：英文句子下面直接显示中文，适合日常阅读英文论文。
- **论文排版双语**：生成可切换「纯中文 / 中英对照 / 纯原文」的自包含 HTML，更强调图片、公式、双栏版式和完整论文结构。

两个工具保留为 Git Submodule，分别跟踪原作者项目，避免把上游源码复制一份后难以更新。

## 一、最简单的使用方法

### 方案 A：逐句双语阅读（推荐普通用户）

第一次使用：

1. 安装 **Python 3.10+** 和 Git。
2. 下载本仓库，并初始化子模块：
   ```bash
   git clone --recurse-submodules https://github.com/dxinyan/fanyi.git
   cd fanyi
   ```
   如果已经下载过：
   ```bash
   git submodule update --init --recursive
   ```
3. 双击 **「初始化环境.bat」**。
4. 打开 `bilingual-paper-reader\\.env`，填写：
   - `MINERU_TOKEN`
   - `OPENROUTER_API_KEY`
   - `TRANSLATION_MODEL`
   - `EXPLANATION_MODEL`
5. 双击 **「启动逐句双语翻译.bat」**。
6. 浏览器会打开 `http://127.0.0.1:8000`，上传英文 PDF 即可。

这个工具的原始项目要求 Python 3.10+，并使用 MinerU 处理 PDF，再通过 OpenAI-compatible 模型接口生成逐句翻译和段落解释。

### 方案 B：论文排版双语 HTML

`translate-academic-paper` **不是一个独立的网页程序**，而是一套给能读写本地文件、执行 Python/shell 的 AI Agent 使用的 Skill。

适合使用 Codex CLI、Claude Code、Gemini CLI、Cursor、Cline、Aider 等。

可以：

1. 把 PDF 拖到 **「使用论文排版翻译.bat」** 上，先自动检查 PDF。
2. 再让 AI Agent 读取：
   - `translate-academic-paper/SKILL.md`
   - `translate-academic-paper/references/runbook.md`
3. 按章节逐段翻译并执行质量检查。
4. 最终用 `combine_paper.py` 生成自包含 HTML。
5. 也可以按需要导出 Word 或纯文本。

仓库里另附了 **「AI翻译提示词.txt」**，可以直接复制给 AI Agent 使用。

## 二、两个工具怎么选？

| 你的需求 | 推荐 |
|---|---|
| 英文一句、中文一句，边看边读 | **Bilingual-Paper-Reader** |
| 论文精读，需要段落级中文解释 | **Bilingual-Paper-Reader** |
| 最终得到完整中英对照 HTML | **translate-academic-paper** |
| 要保留图片、公式、双栏论文结构 | **translate-academic-paper** |
| 扫描论文 / 老书，需要按页面图辅助处理 | **translate-academic-paper** |

## 三、目录

```text
fanyi/
├── .gitmodules
├── README.md
├── 初始化环境.bat
├── 启动逐句双语翻译.bat
├── 使用论文排版翻译.bat
├── AI翻译提示词.txt
├── bilingual-paper-reader/       ← 上游项目 1
└── translate-academic-paper/     ← 上游项目 2
```

## 四、重要说明

### API 密钥

不要把真实 API Key 提交到 GitHub。

`bilingual-paper-reader/.env` 是本地配置文件，不应该上传。仓库已经使用上游项目的 `.gitignore` 规则保护它。

### Git Submodule

本仓库固定了两个上游项目的版本。第一次下载务必使用：

```bash
git clone --recurse-submodules https://github.com/dxinyan/fanyi.git
```

已经 clone 的仓库则运行：

```bash
git submodule update --init --recursive
```

### 上游项目

- [Bilingual-Paper-Reader](https://github.com/fff0301/Bilingual-Paper-Reader)
- [translate-academic-paper](https://github.com/Zaious/translate-academic-paper)

请同时遵守两个上游项目各自的许可证和第三方 API 服务条款。

## 五、下一步

如果你的目标是**“我有一个英文 PDF，双击之后就能开始翻译”**，优先使用：

**初始化环境.bat → 配置 .env → 启动逐句双语翻译.bat**

如果你的目标是**“最终得到一份排版完整、可以离线打开的中英对照论文 HTML”**，使用：

**translate-academic-paper + AI翻译提示词.txt**
