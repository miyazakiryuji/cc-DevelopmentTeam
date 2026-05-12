# ディレクトリ構成（init-dept 実行後）

`/cc-development-team:init-dept` を実行すると、プロジェクトに以下の構成が作られます。

## 構成図

```
your-project/
├── CLAUDE.md                       # プロジェクト全体のルール（全部署が読む）
├── docs/                           # ドキュメント系
│   ├── vision/                     # アプリ構想（design モード A の最初の成果物）
│   │   ├── vision.md               # 構想 / 動機 / ターゲット
│   │   └── roadmap.md              # 機能ロードマップ (MVP/Phase 2/Future)
│   ├── basic-design/               # 基本設計書 = 全体設計（1 ファイル）
│   │   └── basic-design.md         # 機能一覧 / 採用技術 / 画面遷移図 / ER / API / 認証認可
│   ├── requirements/               # 要件定義書（機能ごと）
│   │   ├── login-flow.md
│   │   ├── invoice-export.md
│   │   └── ...
│   ├── specs/                      # 詳細仕様書（機能ごと = 個別設計）
│   │   ├── login-flow.md
│   │   ├── invoice-export.md
│   │   └── ...
│   ├── manual-tasks/               # 人間が UI 操作するタスクの管理
│   │   ├── login-flow.md           # 例: Firebase / OAuth 設定など
│   │   └── ...
│   └── dept/
│       └── architect/CLAUDE.md     # 設計部署メモ（設計方針・ドメイン用語集）
├── design/                         # デザイン素材置き場
│   ├── README.md                   # 何を入れる場所か
│   ├── mockups/                    # 画面モックアップ (Figma export 等)
│   ├── wireframes/                 # ワイヤーフレーム
│   ├── assets/                     # ロゴ・アイコン・画像素材
│   └── style-guide.md              # デザイントークン (色・タイポ・余白)
├── dept/                           # 実作業を行う部署のメモ（コード側）
│   ├── developer/CLAUDE.md         # コーディング規約・ビルドコマンド
│   ├── reviewer/CLAUDE.md          # レビュー観点・severity 判定基準
│   ├── tester/CLAUDE.md            # テスト戦略・実行コマンド・モック方針
│   └── security-reviewer/CLAUDE.md # セキュリティ要件・脅威モデル・PII の取扱
└── src/                            # あなたのソースコード
    └── ...
```

## 配置の考え方

- **`docs/` 配下**: 設計部署（architect）が生み出す成果物。ドキュメント系として `docs/` にまとめる
- **`design/` 配下**: 画像・モックアップ等のバイナリ素材。テキスト中心の `docs/` とは別に分離
- **`dept/` 配下**: 実作業を行う 3 部署（developer / reviewer / tester / security-reviewer）のプロジェクト固有メモ。実コードの傍にいる方が自然なので、プロジェクトルート直下に置く

## 命名ルール

機能名 (`<feature-name>`) は **kebab-case**（英小文字とハイフン）を推奨します（例: `login-flow`, `invoice-export`）。

日本語や空白は避けてください（ファイル名に使うため）。
