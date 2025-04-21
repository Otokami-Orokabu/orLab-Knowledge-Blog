# 記事作成後のGit操作を自動化するPowerShellスクリプト

param(
    [string]$CommitMessage = "記事を追加・更新"
)

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
git push origin-new new-main:main
if ($LASTEXITCODE -ne 0) {
    Write-Host "エラー: プッシュに失敗しました。" -ForegroundColor Red
    exit 1
}

Write-Host "完了しました！" -ForegroundColor Green
Write-Host "GitHub Pagesの更新には数分かかる場合があります。" -ForegroundColor Cyan
Write-Host "サイトは以下のURLで確認できます: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/" -ForegroundColor Cyan
