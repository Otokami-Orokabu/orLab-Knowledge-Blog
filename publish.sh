#!/bin/bash

# 記事作成後のGit操作を自動化するスクリプト

# ヘルプメッセージを表示
show_help() {
  SCRIPT_NAME=$(basename "$0")
  echo "使用方法: ./$SCRIPT_NAME [コミットメッセージ] [オプション]"
  echo ""
  echo "オプション:"
  echo "  --help         このヘルプメッセージを表示"
  echo "  --skip-build   Hugoビルドをスキップ（Hugoがインストールされていない場合に便利）"
  echo ""
  echo "例:"
  echo "  ./$SCRIPT_NAME                           # デフォルトのコミットメッセージ「記事を追加・更新」を使用"
  echo "  ./$SCRIPT_NAME \"AIカテゴリに記事を追加\"    # カスタムコミットメッセージを指定"
  echo "  ./$SCRIPT_NAME --skip-build              # Hugoビルドをスキップ"
  echo "  ./$SCRIPT_NAME \"コミットメッセージ\" --skip-build  # カスタムメッセージでビルドをスキップ"
  echo ""
  echo "説明:"
  echo "  このスクリプトは以下の処理を自動的に行います："
  echo "  1. 現在のブランチが main であることを確認（異なる場合は切り替えを提案）"
  echo "  2. Hugoでサイトをビルド"
  echo "  3. 変更をGitに追加"
  echo "  4. 指定されたメッセージでコミット"
  echo "  5. GitHubにプッシュ（origin main:main）"
  exit 0
}

# オプションの初期化
SKIP_BUILD=false
COMMIT_MSG="記事を追加・更新"

# 引数の処理
for arg in "$@"; do
  if [ "$arg" = "--help" ]; then
    show_help
  elif [ "$arg" = "--skip-build" ]; then
    SKIP_BUILD=true
  elif [[ "$arg" != --* ]]; then
    # ハイフンで始まらない引数はコミットメッセージとして扱う
    COMMIT_MSG="$arg"
  fi
done

# 現在のブランチを確認
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "警告: 現在 '$CURRENT_BRANCH' ブランチにいます。mainブランチに切り替えますか？ (y/n)"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    git checkout main
    if [ $? -ne 0 ]; then
      echo "エラー: mainブランチへの切り替えに失敗しました。"
      exit 1
    fi
  else
    echo "操作をキャンセルしました。mainブランチで作業することをお勧めします。"
    exit 1
  fi
fi

# Hugoビルドの処理
if [ "$SKIP_BUILD" = false ]; then
  # Hugoコマンドが利用可能か確認
  if ! command -v hugo &> /dev/null; then
    echo "エラー: hugoコマンドが見つかりません。"
    echo "Hugoがインストールされているか、PATHが正しく設定されているか確認してください。"
    echo "インストール方法: https://gohugo.io/getting-started/installing/"
    echo "または --skip-build オプションを使用してビルドをスキップしてください。"
    exit 1
  fi

  # サイトをビルド
  echo "Hugoでサイトをビルド中..."
  hugo
  if [ $? -ne 0 ]; then
    echo "エラー: Hugoビルドに失敗しました。"
    exit 1
  fi
else
  echo "Hugoビルドをスキップします..."
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
git push origin main:main
if [ $? -ne 0 ]; then
  echo "エラー: プッシュに失敗しました。"
  exit 1
fi

echo "完了しました！"
echo "GitHub Pagesの更新には数分かかる場合があります。"
echo "サイトは以下のURLで確認できます: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/"
