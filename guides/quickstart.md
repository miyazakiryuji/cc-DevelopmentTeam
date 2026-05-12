# クイックスタート（5 分で動かす）

このガイドは「とりあえずプラグインを動かしてみる」最短ルートです。

## ステップ 1: プラグインをインストール

ターミナルで、試したいプロジェクトのフォルダに移動して Claude Code を起動します。

```bash
cd ~/my-first-app   # ← 自分のプロジェクトフォルダのパスに置き換えてください
claude
```

Claude Code が起動したら、以下を **1 行ずつ** 順番に入力します。

```
/plugin marketplace add miyazakiryuji/cc-DevelopmentTeam
```

```
/plugin install cc-development-team@cc-development-team
```

「インストールが完了しました」のような返事が来たら成功です。

> **補足:** マーケットプレース名・プラグイン名はともに `cc-development-team` です。`@` の前後で同じ名前が2回出てきますが間違いではありません（マーケットプレースとプラグインを別物として識別するため）。

## ステップ 2: プロジェクトを初期化

```
/cc-development-team:init-dept
```

実行すると、Claude Code が **3 つのヒアリング** を順番にしてきます (どれも候補から選ぶだけ、「お任せ」も可):

1. **プロジェクト種別**: Web 開発 / Mobile 開発
2. **設計思想**: お任せ (Feature-based / MVVM 等の推奨) / MVC / Clean Architecture / MVI・TCA / その他
3. **アプリコード配置**: `src/` / `lib/` / `app/` / `apps/+packages/` / その他

回答に応じて、各部署の `CLAUDE.md` テンプレートが **その分野に最適化された内容** で生成され、選んだ設計思想に応じた **アプリコードのフォルダ構成** も作られます。

ヒアリングに答えると、プロジェクトに以下のフォルダ・ファイルが自動で作られます（詳しくは [directory-structure.md](./directory-structure.md)）。

```
my-first-app/
├── CLAUDE.md
├── docs/                # ドキュメント
├── design/              # デザイン素材
├── dept/                # 部署別 CLAUDE.md
└── <選んだ$APP_ROOT>/   # アプリコード本体 (設計思想に応じたサブフォルダ付き)
```

各 `CLAUDE.md` は **Web か Mobile かに応じた雛形** が入った状態で生成されます。具体的な技術スタック名（フレームワーク・ビルドコマンド・カバレッジ目標など）は `<埋める>` プレースホルダになっているので、自分のプロジェクトに合わせて埋めてください。**埋めなくても動きます** が、埋めるほど各部署の精度が上がります。

既にコードが入っているプロジェクトに後付けする場合は、init-dept が **既存ファイルの再配置を提案** します (破壊的な移動は自動実行しません、必ずユーザー承認後に実施)。

> **種別を後から変えたい場合:** 該当する `CLAUDE.md` を手で書き換えるか、ファイルを削除して `/cc-development-team:init-dept` を再実行すると、別の種別で再生成できます。

## ステップ 3: 何から始めるか迷ったら...

**まず迷ったらこれ:**

```
/cc-development-team:guide
```

これを実行すると、「今どんな状況ですか?」と聞いてきます（a〜f の選択肢）。
回答に応じて、次に打つコマンドを **1〜2 個に絞って** 教えてくれます。情報過多にならないので、初学者にも安心です。

## ステップ 4: 自分の状況が分かっているなら直接コマンドを打つ

例:

- **何を作るかまだ思いついていない** → `/cc-development-team:brainstorm`（雑談ベースでアプリ案を 3〜5 個出してくれる）
- **アプリ案はある、仕様書を作りたい** → `/cc-development-team:architect`（引数なしで OK、ヒアリングで進めてくれる）
- **仕様書はある、コードを書きたい** → `/cc-development-team:develop`（develop モードに入る）

`/cc-development-team:architect` を引数なしで実行すると、こんな感じで聞いてきます:

```
【設計コマンド — 何をしますか?】
番号で答えてください:

a) アプリの全体構想から始める
b) 新規の機能を仕様化する
c) 既存の仕様書を更新する
```

ファイル名を覚えていなくても、c) を選べば既存仕様書をリストから選べます。**ユーザーがタイプする負担を減らす設計**になっています。

## 次に読むと良いガイド

- [commands.md](./commands.md) — 各コマンドの詳細
- [workflow.md](./workflow.md) — 業務フローの図解
- [directory-structure.md](./directory-structure.md) — init-dept で作られるフォルダ構成
- [../examples/todo-app-web/](../examples/todo-app-web/) — ドキュメント書き方の見本 (Web Todo アプリのサンプル)
- [faq.md](./faq.md) — よくある質問
