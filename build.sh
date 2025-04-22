#!/bin/bash

# Hugoサイトをローカルでビルドするスクリプト
# 使用方法: ./build.sh

echo "Hugoサイトをビルドしています..."

# サイトをビルド
hugo --minify

echo ""
echo "ビルド完了！"
echo "生成されたファイルは 'docs' ディレクトリにあります"
