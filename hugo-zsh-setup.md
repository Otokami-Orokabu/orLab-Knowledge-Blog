# zshでHugoにパスを通す方法

## 概要

zshシェルでHugoコマンドにパスを通すことで、どのディレクトリからでもHugoコマンドを実行できるようになります。これにより、`publish.sh`スクリプトも正常に動作するようになります。

## 手順

### 1. Hugoのインストール場所を確認

まず、Hugoがインストールされている場所を確認します。Homebrewでインストールした場合は通常、以下のいずれかの場所にあります：

- Intel Mac: `/usr/local/bin/hugo`
- Apple Silicon Mac: `/opt/homebrew/bin/hugo`

確認するには以下のコマンドを実行します：

```bash
which hugo
```

もし何も表示されない場合は、以下のコマンドで検索します：

```bash
find / -name hugo 2>/dev/null
```

### 2. .zshrcファイルを編集

ホームディレクトリにある`.zshrc`ファイルを編集します：

```bash
nano ~/.zshrc
```

または

```bash
code ~/.zshrc
```

### 3. PATHを追加

ファイルの末尾に以下の行を追加します（Hugoの場所に応じて調整）：

Intel Macの場合：
```bash
# Hugoのパスを追加
export PATH=$PATH:/usr/local/bin
```

Apple Silicon Macの場合：
```bash
# Hugoのパスを追加
export PATH=$PATH:/opt/homebrew/bin
```

または、Hugoが別の場所にある場合は、その場所を指定します：
```bash
# Hugoのパスを追加
export PATH=$PATH:/path/to/hugo/directory
```

### 4. 変更を適用

変更を保存した後、以下のコマンドで新しい設定を適用します：

```bash
source ~/.zshrc
```

### 5. 確認

パスが正しく設定されたか確認します：

```bash
which hugo
```

正しいパスが表示され、以下のコマンドでバージョンが表示されれば成功です：

```bash
hugo version
```

## トラブルシューティング

### Hugoが見つからない場合

Hugoがインストールされていない場合は、以下のコマンドでインストールします：

```bash
# Homebrewを使用
brew install hugo
```

### パスが反映されない場合

ターミナルを再起動するか、以下のコマンドを実行します：

```bash
exec $SHELL -l
```

### Homebrewのパスが通っていない場合

Homebrewのパス自体が通っていない場合は、以下を`.zshrc`に追加します：

Intel Macの場合：
```bash
eval "$(/usr/local/bin/brew shellenv)"
```

Apple Silicon Macの場合：
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 参考情報

- [Hugo公式インストールガイド](https://gohugo.io/getting-started/installing/)
- [Homebrew公式サイト](https://brew.sh/)
