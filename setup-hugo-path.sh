#!/bin/bash

# zshでHugoにパスを自動的に通すスクリプト

echo "Hugoのパスを設定します..."

# Hugoのインストール確認
if command -v hugo &> /dev/null; then
    HUGO_PATH=$(which hugo)
    echo "Hugoが見つかりました: $HUGO_PATH"
else
    echo "Hugoが見つかりません。Homebrewでインストールを試みます..."
    
    # Homebrewがインストールされているか確認
    if command -v brew &> /dev/null; then
        echo "Homebrewを使用してHugoをインストールします..."
        brew install hugo
        
        if [ $? -ne 0 ]; then
            echo "エラー: Hugoのインストールに失敗しました。"
            exit 1
        fi
        
        HUGO_PATH=$(which hugo)
        echo "Hugoがインストールされました: $HUGO_PATH"
    else
        echo "エラー: Homebrewが見つかりません。"
        echo "Homebrewをインストールしてから再度試してください: https://brew.sh/"
        exit 1
    fi
fi

# Hugoのディレクトリを取得
HUGO_DIR=$(dirname "$HUGO_PATH")
echo "Hugoのディレクトリ: $HUGO_DIR"

# .zshrcファイルの確認
ZSHRC_FILE="$HOME/.zshrc"
if [ ! -f "$ZSHRC_FILE" ]; then
    echo ".zshrcファイルが見つかりません。新しく作成します..."
    touch "$ZSHRC_FILE"
fi

# すでにパスが設定されているか確認
if grep -q "PATH=.*$HUGO_DIR" "$ZSHRC_FILE"; then
    echo "Hugoのパスはすでに.zshrcに設定されています。"
else
    # Homebrewのパスを追加
    if [[ "$HUGO_DIR" == "/opt/homebrew/bin" ]]; then
        # Apple Silicon Macの場合
        if ! grep -q "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" "$ZSHRC_FILE"; then
            echo "Apple Silicon Mac用のHomebrewパスを追加します..."
            echo "" >> "$ZSHRC_FILE"
            echo "# Homebrewのパスを設定" >> "$ZSHRC_FILE"
            echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> "$ZSHRC_FILE"
        fi
    elif [[ "$HUGO_DIR" == "/usr/local/bin" ]]; then
        # Intel Macの場合
        if ! grep -q "export PATH=.*:/usr/local/bin" "$ZSHRC_FILE"; then
            echo "Intel Mac用のHomebrewパスを追加します..."
            echo "" >> "$ZSHRC_FILE"
            echo "# Homebrewのパスを設定" >> "$ZSHRC_FILE"
            echo "export PATH=\$PATH:/usr/local/bin" >> "$ZSHRC_FILE"
        fi
    else
        # その他の場合
        echo "カスタムパスを追加します: $HUGO_DIR"
        echo "" >> "$ZSHRC_FILE"
        echo "# Hugoのパスを設定" >> "$ZSHRC_FILE"
        echo "export PATH=\$PATH:$HUGO_DIR" >> "$ZSHRC_FILE"
    fi
    
    echo ".zshrcファイルにパスを追加しました。"
fi

# 現在のシェルに反映
echo "新しい設定を現在のシェルに適用します..."
source "$ZSHRC_FILE" 2>/dev/null || true

echo "完了しました！"
echo "新しいターミナルを開くか、以下のコマンドを実行して変更を適用してください："
echo "  source ~/.zshrc"
echo ""
echo "Hugoが正しく設定されたか確認するには、以下のコマンドを実行してください："
echo "  which hugo"
echo "  hugo version"
