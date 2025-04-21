#!/bin/bash

# 記事作成後のGit操作を自動化するスクリプト

# ヘルプメッセージを表示
show_help() {
  SCRIPT_NAME=$(basename "$0")
  echo "使用方法: ./$SCRIPT_NAME [コミットメッセージ] [オプション]"
  echo ""
  echo "オプション:"
  echo "  --help    このヘルプメッセージを表示"
  echo ""
  echo "例:"
  echo "  ./$SCRIPT_NAME                           # デフォルトのコミットメッセージ「記事を追加・更新」を使用"
  echo "  ./$SCRIPT_NAME \"AIカテゴリに記事を追加\"    # カスタムコミットメッセージを指定"
  echo ""
  echo "説明:"
  echo "  このスクリプトは以下の処理を自動的に行います："
  echo "  1. 現在のブランチが new-main であることを確認（異なる場合は切り替えを提案）"
  echo "  2. Hugoでサイトをビルド"
  echo "  3. 変更をGitに追加"
  echo "  4. 指定されたメッセージでコミット"
  echo "  5. GitHubにプッシュ（origin new-main:main）"
  exit 0
}

# ヘルプオプションの確認
if [ "$1" = "--help" ]; then
  show_help
fi

# 引数がない場合はデフォルトのコミットメッセージを使用
if [ -z "$1" ]; then
  COMMIT_MSG="記事を追加・更新"
else
  COMMIT_MSG="$1"
fi

# 現在のブランチを確認
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "new-main" ]; then
  echo "警告: 現在 '$CURRENT_BRANCH' ブランチにいます。new-mainブランチに切り替えますか？ (y/n)"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    git checkout new-main
    if [ $? -ne 0 ]; then
      echo "エラー: new-mainブランチへの切り替えに失敗しました。"
      exit 1
    fi
  else
    echo "操作をキャンセルしました。new-mainブランチで作業することをお勧めします。"
    exit 1
  fi
fi

# サイトをビルド
echo "Hugoでサイトをビルド中..."
hugo
if [ $? -ne 0 ]; then
  echo "エラー: Hugoビルドに失敗しました。"
  exit 1
fi

# 変更をステージングに追加
echo "変更をGitに追加中..."
git add .

# 変更があるか確認
if git diff --cached --quiet; then
  echo "変更はありません。"
  exit 0
fi

# 変更をコミット
echo "変更をコミット中: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"
if [ $? -ne 0 ]; then
  echo "エラー: コミットに失敗しました。"
  exit 1
fi

# リモートにプッシュ
echo "GitHubにプッシュ中..."
git push origin new-main:main
if [ $? -ne 0 ]; then
  echo "エラー: プッシュに失敗しました。"
  exit 1
fi

echo "完了しました！"
echo "GitHub Pagesの更新には数分かかる場合があります。"
echo "サイトは以下のURLで確認できます: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/"
