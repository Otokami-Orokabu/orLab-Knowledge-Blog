#!/bin/bash

# 記事作成後のGit操作を自動化するスクリプト

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
git push origin-new new-main:main
if [ $? -ne 0 ]; then
  echo "エラー: プッシュに失敗しました。"
  exit 1
fi

echo "完了しました！"
echo "GitHub Pagesの更新には数分かかる場合があります。"
echo "サイトは以下のURLで確認できます: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/"
