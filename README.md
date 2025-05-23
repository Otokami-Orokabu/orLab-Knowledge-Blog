# orLab Knowledge Blog

orLab Knowledge Blogは、AI、Unity、Shader、その他の技術情報を整理して共有するためのHugoベースのブログサイトです。

**公開サイト**: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/

## 特徴

- **カテゴリ別整理**: AI、Unity、Shader、Notes、Docsなどのカテゴリで情報を整理
- **タグフィルタリング**: カテゴリページ内でタグによる記事の絞り込みが可能
- **レスポンシブデザイン**: モバイルからデスクトップまで様々なデバイスに対応
- **読みやすさ重視**: 行間、フォントサイズ、コントラストを調整し読みやすさを向上

## 使用方法

### 前提条件

- [Hugo](https://gohugo.io/getting-started/installing/)がインストールされていること
  - zshでHugoにパスを通す方法は[こちら](hugo-zsh-setup.md)を参照
  - 自動セットアップスクリプト: `./setup-hugo-path.sh` を実行するとHugoのパスを自動的に設定します

### ローカル環境での実行

1. リポジトリをクローン
```bash
git clone https://github.com/Otokami-Orokabu/orLab-Knowledge-Blog.git
cd orLab-Knowledge-Blog
```

2. テーマをサブモジュールとして初期化（初回のみ）
```bash
git submodule init
git submodule update
```

3. Hugoをインストール（まだの場合）
```bash
# macOSの場合
brew install hugo

# Windowsの場合
choco install hugo -confirm

# その他の環境は公式サイトを参照
# https://gohugo.io/getting-started/installing/
```

4. ローカルサーバーを起動
```bash
hugo server -D
```

5. ブラウザで http://localhost:1313/orLab-Knowledge-Blog/ にアクセス

### 新しい記事の追加

1. 新しい記事を作成
```bash
# AIカテゴリに新しい記事を作成
hugo new ai/my-new-post.md

# Unityカテゴリに新しい記事を作成
hugo new unity/my-new-post.md

# Shaderカテゴリに新しい記事を作成
hugo new shader/my-new-post.md

# Notesカテゴリに新しい記事を作成
hugo new notes/my-new-post.md

# Docsカテゴリに新しい記事を作成
hugo new docs/my-new-post.md
```

2. 作成されたMarkdownファイルを編集
```markdown
---
title: "記事タイトル"
date: 2025-04-21T00:00:00+09:00
draft: false
tags: ["タグ1", "タグ2"]
categories: ["カテゴリ名"]
---

ここに記事の内容を書きます。
```

3. サイトをビルド
```bash
hugo
```

ビルドされたサイトは `docs/` ディレクトリに出力されます。このディレクトリの内容がGitHub Pagesで公開されます。

4. 変更をコミットしてプッシュ
```bash
git add .
git commit -m "新しい記事を追加"
git push origin main:main
```

または、自動化スクリプトを使用する場合：
```bash
# macOSの場合
./publish.sh "新しい記事を追加"

# Windowsの場合
.\publish.ps1 -CommitMessage "新しい記事を追加"
```

## GitHub Pagesでの公開

1. GitHubリポジトリの設定ページで、GitHub Pagesのソースを `main` ブランチの `/docs` フォルダに設定します。

2. 変更をコミットしてプッシュすると、GitHub Actionsによって自動的にサイトがビルドされ、GitHub Pagesにデプロイされます。

## カスタマイズ

サイトのカスタマイズ内容は [CHANGES.md](docs/CHANGES.md) に記録されています。

## 自動化スクリプト

記事作成後のビルド、コミット、プッシュを自動化するスクリプトが用意されています。

### ローカル開発用スクリプト

以下のスクリプトを使用して、ローカル開発を効率化できます：

- **preview.sh**: ローカルでHugoサーバーを起動し、リアルタイムプレビューを提供します
  ```bash
  # 実行権限を付与（初回のみ）
  chmod +x preview.sh
  
  # スクリプトを実行
  ./preview.sh
  ```
  
- **build.sh**: ローカルでサイトをビルドします
  ```bash
  # 実行権限を付与（初回のみ）
  chmod +x build.sh
  
  # スクリプトを実行
  ./build.sh
  ```

### GitHub Actions による自動デプロイ

このリポジトリには、GitHub Actionsを使用した自動ビルド・デプロイの設定が含まれています。以下の場合に自動的にサイトがビルドされ、GitHub Pagesにデプロイされます：

1. `main` ブランチに以下のファイルの変更がプッシュされた場合：
   - `content/**`: コンテンツファイル
   - `static/**`: 静的ファイル
   - `layouts/**`: レイアウトファイル
   - `config.toml`: 設定ファイル

2. GitHubのActionsタブから手動でワークフローを実行した場合

ワークフローの設定は `.github/workflows/hugo.yml` ファイルで確認できます。

### macOS/Linux (publish.sh)

```bash
# 実行権限を付与（初回のみ）
chmod +x publish.sh

# ヘルプを表示
./publish.sh --help

# デフォルトのコミットメッセージで実行
./publish.sh

# カスタムコミットメッセージで実行
./publish.sh "AIカテゴリに新しい記事を追加"

# Hugoビルドをスキップして実行（Hugoがインストールされていない場合に便利）
./publish.sh --skip-build
./publish.sh "コミットメッセージ" --skip-build

# Hugoの絶対パスを指定して実行（PATHが通っていない場合に便利）
./publish.sh --hugo-path=/usr/local/bin/hugo
./publish.sh "コミットメッセージ" --hugo-path=/opt/homebrew/bin/hugo
```

### Windows (publish.ps1)

```powershell
# ヘルプを表示
.\publish.ps1 -Help

# デフォルトのコミットメッセージで実行
.\publish.ps1

# カスタムコミットメッセージで実行
.\publish.ps1 -CommitMessage "AIカテゴリに新しい記事を追加"

# Hugoビルドをスキップして実行（Hugoがインストールされていない場合に便利）
.\publish.ps1 -SkipBuild
.\publish.ps1 -CommitMessage "コミットメッセージ" -SkipBuild

# Hugoの絶対パスを指定して実行（PATHが通っていない場合に便利）
.\publish.ps1 -HugoPath "C:\Hugo\hugo.exe"
.\publish.ps1 -CommitMessage "コミットメッセージ" -HugoPath "C:\Hugo\hugo.exe"
```

スクリプトは以下の処理を自動的に行います：
1. 現在のブランチが `main` であることを確認（異なる場合は切り替えを提案）
2. Hugoでサイトをビルド
3. 変更をGitに追加
4. 指定されたメッセージでコミット
5. GitHubにプッシュ（`origin main:main`）

## Git ワークフロー

このリポジトリでは以下のブランチ構造を使用しています：

- **main**: ローカル開発用のブランチ。すべての変更はこのブランチで行います。
- **origin/main**: GitHub上のメインブランチ。GitHub Pagesの公開に使用されます。

### 開発の流れ

1. 常に `main` ブランチで作業を行います
```bash
# 現在のブランチを確認
git branch

# もし別のブランチにいる場合は main に切り替え
git checkout main
```

2. 変更を加えた後、コミットします
```bash
git add .
git commit -m "変更内容の説明"
```

3. 変更をGitHubにプッシュします
```bash
git push origin main:main
```
このコマンドは、ローカルの `main` ブランチの内容をリモートの `main` ブランチにプッシュします。

## ディレクトリ構造

```
orLab-Knowledge-Blog/
├── .github/
│   └── workflows/
│       └── hugo.yml
├── archetypes/
│   └── default.md
├── content/
│   ├── ai/
│   │   └── sample.md
│   ├── unity/
│   ├── notes/
│   ├── docs/
│   └── shader/
├── docs/          # GitHub Pages 用ビルド出力
├── layouts/       # カスタムレイアウト
├── static/
│   ├── css/
│   │   └── custom.css
│   └── images/
│       └── sample.jpg
├── themes/
│   └── ananke/    # サブモジュールとして追加
├── .gitignore
├── .gitmodules
├── config.toml
└── README.md
```

## ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。
