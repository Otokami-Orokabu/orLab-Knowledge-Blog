# 記事作成後のGit操作を自動化するPowerShellスクリプト

param(
    [string]$CommitMessage = "記事を追加・更新",
    [switch]$Help
)

# ヘルプメッセージを表示
function Show-Help {
    Write-Host "使用方法: .\publish.ps1 [-CommitMessage <メッセージ>] [-Help]" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "パラメータ:" -ForegroundColor Cyan
    Write-Host "  -CommitMessage <メッセージ>  コミットメッセージを指定（デフォルト: '記事を追加・更新'）"
    Write-Host "  -Help                      このヘルプメッセージを表示"
    Write-Host ""
    Write-Host "例:" -ForegroundColor Cyan
    Write-Host "  .\publish.ps1                                # デフォルトのコミットメッセージを使用"
    Write-Host "  .\publish.ps1 -CommitMessage 'AIカテゴリに記事を追加'  # カスタムコミットメッセージを指定"
    Write-Host ""
    Write-Host "説明:" -ForegroundColor Cyan
    Write-Host "  このスクリプトは以下の処理を自動的に行います：" -ForegroundColor White
    Write-Host "  1. 現在のブランチが new-main であることを確認（異なる場合は切り替えを提案）"
    Write-Host "  2. Hugoでサイトをビルド"
    Write-Host "  3. 変更をGitに追加"
    Write-Host "  4. 指定されたメッセージでコミット"
    Write-Host "  5. GitHubにプッシュ（origin new-main:main）"
    exit 0
}

# ヘルプオプションの確認
if ($Help) {
    Show-Help
}

# 現在のブランチを確認
$CurrentBranch = git branch --show-current
if ($CurrentBranch -ne "new-main") {
    Write-Host "警告: 現在 '$CurrentBranch' ブランチにいます。new-mainブランチに切り替えますか？ (y/n)" -ForegroundColor Yellow
    $answer = Read-Host
    if ($answer -eq "y" -or $answer -eq "Y") {
        Write-Host "new-mainブランチに切り替えます..." -ForegroundColor Cyan
        git checkout new-main
        if ($LASTEXITCODE -ne 0) {
            Write-Host "エラー: new-mainブランチへの切り替えに失敗しました。" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "操作をキャンセルしました。new-mainブランチで作業することをお勧めします。" -ForegroundColor Red
        exit 1
    }
}

# サイトをビルド
Write-Host "Hugoでサイトをビルド中..." -ForegroundColor Cyan
hugo
if ($LASTEXITCODE -ne 0) {
    Write-Host "エラー: Hugoビルドに失敗しました。" -ForegroundColor Red
    exit 1
}

# 変更をステージングに追加
Write-Host "変更をGitに追加中..." -ForegroundColor Cyan
git add .

# 変更があるか確認
$hasChanges = git diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "変更はありません。" -ForegroundColor Yellow
    exit 0
}

# 変更をコミット
Write-Host "変更をコミット中: $CommitMessage" -ForegroundColor Cyan
git commit -m $CommitMessage
if ($LASTEXITCODE -ne 0) {
    Write-Host "エラー: コミットに失敗しました。" -ForegroundColor Red
    exit 1
}

# リモートにプッシュ
Write-Host "GitHubにプッシュ中..." -ForegroundColor Cyan
git push origin new-main:main
if ($LASTEXITCODE -ne 0) {
    Write-Host "エラー: プッシュに失敗しました。" -ForegroundColor Red
    exit 1
}

Write-Host "完了しました！" -ForegroundColor Green
Write-Host "GitHub Pagesの更新には数分かかる場合があります。" -ForegroundColor Cyan
Write-Host "サイトは以下のURLで確認できます: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/" -ForegroundColor Cyan
