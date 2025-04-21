#!/bin/bash

# Apple Silicon Mac用のHomebrewパスを.zshrcに設定するスクリプト

echo "Apple Silicon Mac用のHomebrewパスを設定します..."

# .zshrcファイルの確認
ZSHRC_FILE="$HOME/.zshrc"
if [ ! -f "$ZSHRC_FILE" ]; then
    echo ".zshrcファイルが見つかりません。新しく作成します..."
    touch "$ZSHRC_FILE"
fi

# Homebrewのパスが設定されているか確認
if grep -q "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" "$ZSHRC_FILE"; then
    echo "Homebrewのパスはすでに.zshrcに設定されています。"
else
    # Apple Silicon Mac用のHomebrewパスを追加
    echo "" >> "$ZSHRC_FILE"
    echo "# Homebrewのパスを設定" >> "$ZSHRC_FILE"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$ZSHRC_FILE"
    echo ".zshrcファイルにHomebrewのパスを追加しました。"
fi

# 現在のシェルに反映
echo "新しい設定を現在のシェルに適用します..."
source "$ZSHRC_FILE" 2>/dev/null || true

echo "完了しました！"
echo "新しいターミナルを開くか、以下のコマンドを実行して変更を適用してください："
echo "  source ~/.zshrc"
echo ""
echo "Homebrewが正しく設定されたか確認するには、以下のコマンドを実行してください："
echo "  which brew"
echo "  brew --version"
echo ""
echo "Hugoが正しく設定されたか確認するには、以下のコマンドを実行してください："
echo "  which hugo"
echo "  hugo version"
