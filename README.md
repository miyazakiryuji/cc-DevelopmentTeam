# cc-DevelopmentTeam

> A Claude Code plugin that brings a 4-department workflow (design / develop / review / test) with automatic spec back-fill.

## 概要

`cc-DevelopmentTeam` は、Claude Code 上のソフトウェア開発を **設計 / 開発 / レビュー / テスト** の4部署体制で運用するためのプラグインです。各部署を独立したサブエージェントとして提供し、コマンドから順序立てて呼び出すことで、属人化しがちな開発フローを再現可能なパイプラインに変えます。

このプラグインの最大の特徴は **「設計を通さずに開発した場合でも、完了時に必ず仕様書が back-fill される」** ことです。`/cc-development-team:develop` フローでは、実装後に設計部署 (`architect`) が走り、`docs/specs/<feature-name>.md` を逆生成します。「動くものが先、仕様書は後」という現実的な進め方をしても、ナレッジが必ずリポジトリに残ります。

## インストール方法

### ローカル（開発時）

ローカルの作業ディレクトリから直接ロードする場合:

```bash
claude --plugin-dir /path/to/cc-DevelopmentTeam
```

または、Claude Code 内でマーケットプレースとして登録する場合:

```
/plugin marketplace add /path/to/cc-DevelopmentTeam
```

### GitHub 経由

GitHub に公開済みの場合、2 ステップでインストールします:

```
# 1. このリポジトリをマーケットプレースとして登録
/plugin marketplace add miyazakiryuji/cc-DevelopmentTeam

# 2. プラグイン本体をインストール
/plugin install cc-development-team@cc-development-team
```

（マーケットプレース名・プラグイン名ともに `cc-development-team` です）

## 使い方

### 1. プロジェクトを初期化する

```
/cc-development-team:init-dept
```

`docs/specs/` ディレクトリを作成し、`CLAUDE.md` に運用方針セクションを追記します。

### 2. 設計先行ルート（推奨）

新機能の要件が固まっている場合、または影響範囲が広い場合:

```
/cc-development-team:feature <feature-name>
```

`architect` → `developer` → `reviewer` → `tester` の順で進行します。仕様書を先に書き、それに沿って実装・レビュー・テストを行います。

### 3. 開発先行ルート（back-fill 付き）

プロトタイプを先に作りたい、または小さな改修で要件が明らかな場合:

```
/cc-development-team:develop <feature-name>
```

`developer` → `reviewer` → `architect`（back-fill） → `tester` の順で進行します。実装が終わった後で仕様書が **必ず** 逆生成されるため、ドキュメント負債が溜まりません。

### 4. 整合性チェック

仕様書と実コードのズレを点検します:

```
/cc-development-team:sync-spec [feature-name]
```

引数を省略すると `docs/specs/*.md` の全件をチェックします。

## 提供エージェント一覧

| エージェント | 役割 |
| --- | --- |
| `architect` | **設計部署**。要件整理・アーキテクチャ判断・受け入れ基準策定を行い、`docs/specs/<feature-name>.md` を作成/更新する。 |
| `developer` | **開発部署**。仕様書に基づき最小差分で実装する。仕様書がない場合は back-fill 用の変更ログを残す。 |
| `reviewer` | **レビュー部署**。仕様との整合性、品質、セキュリティを点検し severity 付きで指摘する。コードは書き換えない。 |
| `tester` | **テスト部署**。受け入れ基準をテストに翻訳し、適切なレイヤで追加・実行する。 |

## 業務フロー

### 設計先行ルート (`/cc-development-team:feature`)

```
ユーザー依頼
   ↓
[architect] 仕様書を docs/specs/<name>.md に作成
   ↓ (ユーザー承認)
[developer] 仕様書に基づき実装
   ↓
[reviewer]  品質・セキュリティ・整合性を点検
   ↓ (Approve)
[tester]    受け入れ基準をテストに翻訳・実行
   ↓
完了報告
```

### 開発先行ルート (`/cc-development-team:develop`)

```
ユーザー依頼
   ↓
[developer] とりあえず実装（変更ログを残す）
   ↓
[reviewer]  コード品質を点検（仕様整合はスキップ）
   ↓ (Approve)
[architect] 実装内容から docs/specs/<name>.md を逆生成 ← back-fill
   ↓
[tester]    back-fill された仕様からテストを補完
   ↓
完了報告
```

## ディレクトリ規約

仕様書は **必ず** `docs/specs/<feature-name>.md` に集約します。
各部署のプロジェクト固有メモは `docs/dept/<部署名>/CLAUDE.md` に置き、サブエージェントが起動時に自動で読み込みます。

```
your-project/
├── CLAUDE.md                       # プロジェクト共通ルール（全部署が読む）
├── docs/
│   ├── specs/                      # 仕様書（feature 単位）
│   │   ├── login-flow.md
│   │   ├── invoice-export.md
│   │   └── ...
│   └── dept/                       # 部署別のプロジェクト固有メモ
│       ├── architect/CLAUDE.md     # 設計方針・ドメイン用語集
│       ├── developer/CLAUDE.md     # コーディング規約・ビルドコマンド
│       ├── reviewer/CLAUDE.md      # レビュー観点・severity 判定基準
│       └── tester/CLAUDE.md        # テスト戦略・実行コマンド・モック方針
└── src/
    └── ...
```

`<feature-name>` は kebab-case を推奨します（例: `login-flow`, `invoice-export`）。

`/cc-development-team:init-dept` を一度実行すると、上記の `docs/specs/` と `docs/dept/<部署>/CLAUDE.md` 4 枚のテンプレが生成されます。
各テンプレを埋めるほど、サブエージェントの判断精度が上がります（埋めなくても標準動作はします）。

## ライセンス

[MIT](./LICENSE)
