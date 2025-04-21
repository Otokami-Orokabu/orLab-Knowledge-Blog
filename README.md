# orLab Knowledge Blog

orLab Knowledge Blogは、AI、Unity、Shader、その他の技術情報を整理して共有するためのHugoベースのブログサイトです。

## 特徴

- **カテゴリ別整理**: AI、Unity、Shader、Notes、Docsなどのカテゴリで情報を整理
- **タグフィルタリング**: カテゴリページ内でタグによる記事の絞り込みが可能
- **レスポンシブデザイン**: モバイルからデスクトップまで様々なデバイスに対応
- **読みやすさ重視**: 行間、フォントサイズ、コントラストを調整し読みやすさを向上

## 使用方法

### ローカル環境での実行

1. リポジトリをクローン
```bash
git clone https://github.com/Otokami-Orokabu/orLab-Knowledge-Blog.git
cd orLab-Knowledge-Blog
```

2. Hugoをインストール（まだの場合）
```bash
# macOSの場合
brew install hugo

# Windowsの場合
choco install hugo -confirm

# その他の環境は公式サイトを参照
# https://gohugo.io/getting-started/installing/
```

3. ローカルサーバーを起動
```bash
hugo server -D
```

4. ブラウザで http://localhost:1313/orLab-Knowledge-Blog/ にアクセス

### 新しい記事の追加

1. 新しい記事を作成
```bash
# AIカテゴリに新しい記事を作成
hugo new ai/my-new-post.md

# Unityカテゴリに新しい記事を作成
hugo new unity/my-new-post.md
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

4. 変更をコミットしてプッシュ
```bash
git add .
git commit -m "新しい記事を追加"
git push origin-new new-main:main
```

## カスタマイズ

サイトのカスタマイズ内容は [CHANGES.md](docs/CHANGES.md) に記録されています。

## Git ワークフロー

このリポジトリでは以下のブランチ構造を使用しています：

- **new-main**: ローカル開発用のブランチ。すべての変更はこのブランチで行います。
- **origin/main**: GitHub上のメインブランチ。GitHub Pagesの公開に使用されます。

### 開発の流れ

1. 常に `new-main` ブランチで作業を行います
```bash
# 現在のブランチを確認
git branch

# もし別のブランチにいる場合は new-main に切り替え
git checkout new-main
```

2. 変更を加えた後、コミットします
```bash
git add .
git commit -m "変更内容の説明"
```

3. 変更をGitHubにプッシュします
```bash
git push origin-new new-main:main
```
このコマンドは、ローカルの `new-main` ブランチの内容をリモートの `main` ブランチにプッシュします。

## ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。
