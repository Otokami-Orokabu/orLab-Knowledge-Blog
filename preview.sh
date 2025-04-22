#!/bin/bash

# Hugoサーバーを起動してサイトをプレビューするスクリプト
# 使用方法: ./preview.sh

echo "Hugoサーバーを起動しています..."
echo "プレビューを終了するには Ctrl+C を押してください"
echo "ブラウザで http://localhost:1313/ を開いてサイトをプレビューできます"
echo ""

# Hugoサーバーを起動（ファイル変更を監視して自動的に再ビルド）
hugo server --watch --buildDrafts --buildFuture
