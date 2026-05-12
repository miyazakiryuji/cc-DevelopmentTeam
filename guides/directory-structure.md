# ディレクトリ構成（init-dept 実行後）

`/cc-development-team:init-dept` を実行すると、プロジェクトに以下の構成が作られます。

## 構成図

```
your-project/
├── CLAUDE.md                       # プロジェクト全体のルール（全部署が読む）
├── docs/                           # ドキュメント系（テキスト中心）
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
├── design/                         # デザイン素材置き場（画像・バイナリ中心）
│   ├── mockups/                    # 画面モックアップ (Figma export 等)
│   ├── wireframes/                 # ワイヤーフレーム
│   ├── assets/                     # ロゴ・アイコン・画像素材
│   └── style-guide.md              # デザイントークン (色・タイポ・余白)
├── dept/                           # 実作業を行う部署のメモ（コード側）
│   ├── developer/CLAUDE.md         # コーディング規約・ビルドコマンド
│   ├── reviewer/CLAUDE.md          # レビュー観点・severity 判定基準
│   ├── tester/CLAUDE.md            # テスト戦略・実行コマンド・モック方針
│   └── security-reviewer/CLAUDE.md # セキュリティ要件・脅威モデル・PII の取扱
└── src/                            # あなたのソースコード（または apps/, packages/ など）
    └── ...
```

## 配置の考え方

- **`docs/` 配下**: 設計部署（architect）が生み出す成果物。テキスト中心のドキュメントを集約
- **`design/` 配下**: 画像・モックアップ等のバイナリ素材。テキスト中心の `docs/` とは別に分離
- **`dept/` 配下**: 実作業を行う 4 部署（developer / reviewer / tester / security-reviewer）のプロジェクト固有メモ。実コードの傍にいる方が自然なので、プロジェクトルート直下に置く

---

## 各フォルダの役割と格納するもの

### `CLAUDE.md`（ルート）

**役割:** プロジェクト全体のルール。全部署（全エージェント）が読み込む。

**入れるもの:**
- プロジェクト概要（何を作るか）
- プロジェクト種別（Web / iOS / Android / KMP / Flutter / RN 等）
- 全部署共通の禁止事項
- 主要なディレクトリ構成への案内

**入れないもの:**
- 部署固有のルール → `dept/<部署>/CLAUDE.md` に書く
- 機能仕様 → `docs/specs/<feature-name>.md` に書く

---

### `docs/vision/`

**役割:** アプリの構想・動機・ターゲットなど、「何のために作るか」を保存する。

**入れるもの:**
- `vision.md`: アプリ名 / 動機 / ターゲットユーザー / 解決したい課題
- `roadmap.md`: MVP / Phase 2 / Future の機能ロードマップ

**入れないもの:**
- 個別機能の詳細仕様 → `docs/specs/` に書く
- 画面のモックアップ → `design/mockups/` に置く

---

### `docs/basic-design/`

**役割:** 基本設計書 = プロジェクト全体を俯瞰する設計書。**1 プロジェクト 1 ファイル** がベース。

**入れるもの:**
- `basic-design.md`: 機能一覧（F-XXX 採番）/ 採用技術スタック / 画面遷移図（全体）/ ER 図 / API 一覧 / 認証認可方針 / 非機能要件
- `_template.md`: 基本設計書のテンプレート（init-dept で配置される）

**入れないもの:**
- 機能ごとの詳細 → `docs/requirements/` と `docs/specs/` に分けて書く
- 画面のビジュアル → `design/mockups/` に置く

---

### `docs/requirements/`

**役割:** 要件定義書 = 「何を実現するか」を機能ごとに記述。**1 機能 = 1 ファイル**。

**入れるもの:**
- `<feature-name>.md`: 機能 ID（F-XXX）/ ユーザーストーリー / 受け入れ基準 / 業務要件 / 制約条件
- `_template.md`: 要件定義書のテンプレート

**入れないもの:**
- 実装手順や API シグネチャ → `docs/specs/` に書く（要件は「何を」、仕様は「どう実現するか」）

---

### `docs/specs/`

**役割:** 詳細仕様書 = 「どう実装するか」を機能ごとに記述。**1 機能 = 1 ファイル**。develop が読む。

**入れるもの:**
- `<feature-name>.md`: API シグネチャ / データモデル / 画面構成 / バリデーション / エラーケース / テスト観点 / 関連デザイン素材へのリンク
- `_template.md`: 詳細仕様書のテンプレート

**入れないもの:**
- 業務要件・ユーザーストーリー → `docs/requirements/` に書く
- 採用技術全体方針 → `docs/basic-design/` に書く

---

### `docs/manual-tasks/`

**役割:** 人間が UI で操作しないと進まないタスクを追跡。Firebase コンソール / OAuth クライアント発行 / DNS 設定など。

**入れるもの:**
- `<feature-name>.md`: 機能ごとの手動タスク。各タスクに「手順」「完了の確認方法」「関連コード」「ステータス（☐未完了 / ☑完了 YYYY-MM-DD）」
- `_template.md`: 手動タスクのテンプレート

**入れないもの:**
- コードで自動化できる作業 → `docs/specs/` に書いて開発者に任せる

> 連動: ソースコードに `// TODO(manual): docs/manual-tasks/<feature>.md#<見出し> — <未完了内容>` が残されます。タスク完了時はファイル内ステータスを `☑` にし、コードの TODO も削除。

---

### `docs/dept/architect/CLAUDE.md`

**役割:** 設計部署（architect）のプロジェクト固有メモ。

**入れるもの:**
- 設計方針（モノリス / マイクロサービス / モジュール構造）
- ドメイン用語集（業界特有の用語の意味）
- 既知の制約（パフォーマンス目標、対応ブラウザ、想定同時接続数 等）
- 過去の設計判断とその理由

**入れないもの:**
- コーディング規約 → `dept/developer/CLAUDE.md` に書く

---

### `design/`（プロジェクト直下）

**役割:** デザイン関連のバイナリ素材を集約。`docs/`（テキスト）とは別に分離。

> プロジェクトルートの README 以外、各フォルダ内には説明用 README を置きません。フォルダごとの用途はこの guides を参照してください。

#### `design/mockups/`

**入れるもの:**
- 画面の完成イメージ。Figma エクスポート / PNG / JPG / PDF
- 例: `login-screen.png`, `home-mockup-v2.fig`, `dashboard.pdf`

**入れないもの:**
- 本番ビルドに含める画像 → ソースコード側（`public/`, `assets/`）に別途配置

> developer は UI 実装時、機能名を含むファイル / フォルダを優先的に参照します。

#### `design/wireframes/`

**入れるもの:**
- 構造重視の粗いラフ・ワイヤー
- 例: `login-wireframe.png`, `flow-rough-v1.pdf`

**入れないもの:**
- 詳細なビジュアルデザイン → `mockups/` に置く

#### `design/assets/`

**入れるもの:**
- ロゴ / アイコン / イラスト等のデザインソース
- 例: `logo.svg`, `app-icon-1024.png`, `illustrations/`

**入れないもの:**
- 本番ビルドの最終アセット → ソースコード側

#### `design/style-guide.md`

**入れるもの:**
- カラーパレット（Primary / Secondary / Success / Warning / Error / Info）
- タイポグラフィ（フォントファミリー / 見出しサイズ / 行間）
- 余白・グリッド（4px or 8px ベース / コンテナ最大幅）
- コンポーネント方針（ボタン状態 / フォーム部品 / カード影 等）

> develop モードで UI 実装時、`developer` がこのファイルを必ず参照しスタイルの一貫性を保ちます。

---

### `dept/developer/CLAUDE.md`

**役割:** 開発部署（developer）のプロジェクト固有メモ。

**入れるもの:**
- コーディング規約（命名 / インデント / コメント方針）
- 採用フレームワークの方針（例: React は関数コンポーネント、状態管理は Zustand）
- ビルド・型チェック・テスト実行コマンド
- 避けたい書き方（例: `any` 禁止 / `console.log` をコミットしない 等）

**入れないもの:**
- 機能仕様 → `docs/specs/` に書く

---

### `dept/reviewer/CLAUDE.md`

**役割:** レビュー部署のプロジェクト固有メモ。

**入れるもの:**
- レビュー観点（重視するポイント）
- severity 判定基準（Blocker / Major / Minor の線引き）
- 既知のレガシーコードと回避策

**入れないもの:**
- セキュリティ専門の点検観点 → `dept/security-reviewer/CLAUDE.md` に書く

---

### `dept/tester/CLAUDE.md`

**役割:** テスト部署のプロジェクト固有メモ。

**入れるもの:**
- テスト戦略（ユニット / 統合 / E2E の使い分け）
- テスト実行コマンド（`npm test`, `pytest -k`, `go test ./...` 等）
- モック方針（DB / 外部 API は本物 or モック）
- テストデータ・フィクスチャの管理場所

---

### `dept/security-reviewer/CLAUDE.md`

**役割:** セキュリティ専門のプロジェクト固有メモ。

**入れるもの:**
- 取り扱う個人情報（PII）の種類
- 適用される規制（GDPR / 個人情報保護法 / PCI-DSS 等）
- 脅威モデル（想定攻撃者と攻撃面）
- 既知の脆弱性履歴と対応状況

**入れないもの:**
- 一般的なセキュリティ知識 → 不要（security-reviewer エージェントが OWASP Top 10 等は標準装備）

---

### `src/`（または `apps/`, `packages/` など）

**役割:** あなたのソースコード本体。プラグインは生成しないので、ユーザーが採用しているフレームワークの慣習に従って配置してください。

**入れるもの:**
- アプリケーションコード（フロントエンド / バックエンド / モバイル）
- 自動テスト
- ビルド成果物以外のすべて

---

## 命名ルール

機能名 (`<feature-name>`) は **kebab-case**（英小文字とハイフン）を推奨します（例: `login-flow`, `invoice-export`）。

日本語や空白は避けてください（ファイル名に使うため）。

## 空のままで OK か？

| フォルダ | 空でも OK? | 補足 |
| --- | --- | --- |
| `docs/vision/` | OK | brainstorm 経由なら自動で埋まる |
| `docs/basic-design/` | OK | design モード A で埋まる |
| `docs/requirements/` | OK | design モード B で機能ごとに追加 |
| `docs/specs/` | OK | design モード B で機能ごとに追加 |
| `docs/manual-tasks/` | OK | 必要が出てから自動作成される |
| `design/mockups/` | OK | モックアップが無くても実装は進む |
| `design/wireframes/` | OK | |
| `design/assets/` | OK | |
| `design/style-guide.md` | 埋めると効果大 | カラー / 余白の一貫性が保たれる |
| `dept/*/CLAUDE.md` | 空でも OK | プロジェクト固有ルールを書き足すほど精度が上がる |
| `CLAUDE.md`（ルート） | 最低限の記述推奨 | init-dept で雛形が入る |
