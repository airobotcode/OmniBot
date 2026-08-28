
# ========================================================
# OmniBot 核心功能与 CI/CD 自动化管理脚本 (PowerShell)
# ========================================================

# 1. 自动配置网络代理
function Set-OmniBotEnv {
    param([string]$ProxyUrl = "http://127.0.0.1:7890")
    $env:HTTP_PROXY = $ProxyUrl
    $env:HTTPS_PROXY = $ProxyUrl
    Write-Host "[✓] 网络代理已成功设置为: $ProxyUrl" -ForegroundColor Green
}

# 2. 批量生成与更新项目核心配置
function Update-OmniBotCodebase {
    Write-Host "[1/2] 正在更新 lib/config/app_config.dart..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path "lib\config" | Out-Null
    
    $configContent = @"
class AppConfig {
  static const String appName = "OmniBot";
  static const String version = "1.5.0";
  static const String tagline = "开源 · 零中转 · 隐私优先的跨平台大模型原生客户端";
  static const List<String> supportedProviders = [
    "Gemini (Direct)", "Claude (Direct)", "OpenAI (Direct)", "Ollama (Local IP)"
  ];
}
"@
    Set-Content -Path "lib\config\app_config.dart" -Encoding UTF8 -Value $configContent
    Write-Host "[✓] 核心项目代码与全套配置更新完毕！" -ForegroundColor Green
}

# 3. 批量本地构建 (Web / Windows / Android)
function Build-OmniBotAll {
    Write-Host "[1/3] 编译 Web (GitHub Pages 路径)..." -ForegroundColor Cyan
    flutter build web --release --base-href "/OmniBot/"

    Write-Host "[2/3] 编译 Windows 桌面端..." -ForegroundColor Cyan
    flutter build windows --release

    Write-Host "[3/3] 编译 Android APK..." -ForegroundColor Cyan
    flutter build apk --release

    Write-Host "[✓] 本地多平台构建已全部完成！" -ForegroundColor Green
}

# 4. Git 提交与 Tag 触发 Github Actions 自动构建
function Publish-OmniBotRelease {
    param(
        [string]$Version = "v1.5.0",
        [string]$Message = "feat: complete all core modules (Direct API, SQLite, Proxy & i18n)"
    )
    Set-OmniBotEnv
    git add .
    git commit -m $Message
    git push origin main
    
    # 清理旧 Tag 并重新推送新 Tag
    git tag -d $Version 2>$null
    git push origin ":refs/tags/$Version" 2>$null
    git tag $Version
    git push origin $Version

    Write-Host "[✓] 发布指令已发送！GitHub Actions 开始自动部署全平台构建。" -ForegroundColor Green
}

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host " OmniBot 自动化工具箱已成功导入终端！" -ForegroundColor Yellow
Write-Host " 可用命令:" -ForegroundColor Yellow
Write-Host "   Set-OmniBotEnv         - 设置代理 (默认 127.0.0.1:7890)" -ForegroundColor Gray
Write-Host "   Update-OmniBotCodebase - 重新写入核心文件配置" -ForegroundColor Gray
Write-Host "   Build-OmniBotAll       - 一键编译 Web/Win/Android" -ForegroundColor Gray
Write-Host "   Publish-OmniBotRelease - 提交 Git 并触发 Git Tag 自动发布" -ForegroundColor Gray
Write-Host "==========================================" -ForegroundColor Yellow

