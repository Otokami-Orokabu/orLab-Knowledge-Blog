# Hugoサイト構築依頼：orLab Knowledge

## 概要
GitHub Pages用に、Hugoを使った構造化ブログ「orLab Knowledge」を構築したいです。以下の要件に沿って、スターターリポジトリを生成してください。

## 必要な構成
- Hugoで初期化されたプロジェクト
- テーマ：`ananke`（submodule可）
- `content/` 以下に以下のカテゴリを用意：
  - `ai/`
  - `unity/`
  - `notes/`
  - `docs/`
- トップページは：
  - 最近の記事一覧
  - カテゴリ別リンク（サイドバー or トップに）
- `static/images/` にサンプル画像（Drive参照の場合は不要）
- `public/` → `docs/` にリネームして GitHub Pages 用に出力
- `config.toml` にサイトタイトル `orLab Knowledge` を記述
- `README.md` に使用方法とビルド手順を記載
- `GitHub Actions` による自動デプロイ設定（`main`ブランチでpush時）

## サンプル記事（最低1件）
`content/ai/sample.md` に以下の内容で：

```markdown
---
title: "Prompt設計サンプル"
date: 2025-04-20
tags: ["ai", "prompt", "structure"]
---

これはAIプロンプト構造のメモです。  
Drive画像を埋め込む場合は以下の形式を使用します：

![構造図](https://drive.google.com/uc?export=view&id=xxxxxxxxxxxxxxxxxx)

最終成果物

GitHubリポジトリ構成一式を提供してください。
CLIから hugo 実行で docs/ が生成され、GitHub Pagesで公開できるようにしてください。
