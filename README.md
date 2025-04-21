# orLab Knowledge

GitHub Pages用のHugoで構築された構造化ブログ「orLab Knowledge」です。

**公開サイト**: https://otokami-orokabu.github.io/orLab-Knowledge-Blog/

## 使用方法

### 前提条件
- [Hugo](https://gohugo.io/getting-started/installing/)がインストールされていること

### ローカルでの開発

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

3. ローカルサーバーを起動
```bash
hugo server -D
```

4. ブラウザで http://localhost:1313 にアクセス

### 新しい記事の作成

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

### ビルド手順

```bash
# docs/ディレクトリにサイトをビルド
hugo
```

ビルドされたサイトは `docs/` ディレクトリに出力されます。このディレクトリの内容がGitHub Pagesで公開されます。

## GitHub Pagesでの公開

1. GitHubリポジトリの設定ページで、GitHub Pagesのソースを `main` ブランチの `/docs` フォルダに設定します。

2. 変更をコミットしてプッシュすると、GitHub Actionsによって自動的にサイトがビルドされ、GitHub Pagesにデプロイされます。

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
├── static/
│   └── images/
│       └── sample.jpg
├── themes/
│   └── ananke/    # サブモジュールとして追加
├── .gitignore
├── .gitmodules
├── config.toml
└── README.md
