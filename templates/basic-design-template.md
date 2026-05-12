# <プロジェクト名> 基本設計書（全体設計）

<!--
このファイルは設計部署 (architect) がアプリ構想モード A で読み込むテンプレートです。
docs/basic-design/basic-design.md として書き出されます。

ここに書くのは **プロジェクト全体の設計** (= 画面遷移・全体アーキテクチャ・データモデル
俯瞰・API 一覧 等) です。
**個別機能の詳細** は以下にあります:
- 機能ごと要件: docs/requirements/<feature-name>.md
- 機能ごと詳細仕様: docs/specs/<feature-name>.md
-->

**関連ドキュメント:**
- 構想: [docs/vision/vision.md](../vision/vision.md)
- 機能ロードマップ: [docs/vision/roadmap.md](../vision/roadmap.md)
- 機能ごと要件: [docs/requirements/](../requirements/)
- 機能ごと詳細仕様: [docs/specs/](../specs/)
- デザイン素材（モックアップ・スタイルガイド等）: [design/](../../design/)

## 1. システム構成

### 1.1 全体構成図

<!-- システムアーキテクチャ図 (テキスト or ASCII) -->

```
[ クライアント (Web/Mobile) ] ── HTTPS ──> [ API サーバ ] ── ORM ──> [ DB ]
                                              │
                                              └── 外部サービス
```

### 1.2 主要コンポーネント

| コンポーネント | 役割 |
| --- | --- |
| | |

### 1.3 採用技術スタック

- 言語: <Swift / Kotlin / TypeScript / Python 等>
- フロントエンドフレームワーク: <SwiftUI / Jetpack Compose / Next.js / Vue 等>
- バックエンドフレームワーク: <Express / Django / Rails / Ktor 等>
- データベース: <PostgreSQL / MySQL / Firestore / SQLite 等>
- 認証: <OAuth / Firebase Auth / Auth0 / 独自 等>
- インフラ: <Vercel / AWS / Firebase / Supabase 等>
- CI/CD: <GitHub Actions / Vercel Deploy 等>

## 2. 機能一覧（全体俯瞰）

<!--
roadmap.md と整合させた機能の一覧。各機能は requirements/<name>.md と specs/<name>.md
にリンクされる。機能 ID (F-XXX) はここでマスター管理する。
-->

| 機能 ID | feature-name | 機能名 | 優先度 | 要件定義書 | 詳細仕様書 |
| --- | --- | --- | --- | --- | --- |
| F-001 | login-flow | ログイン | MVP | [requirements](../requirements/login-flow.md) | [specs](../specs/login-flow.md) |
| F-002 | book-search | 書籍検索 | MVP | [requirements](../requirements/book-search.md) | [specs](../specs/book-search.md) |

## 3. 画面設計（全体俯瞰）

### 3.1 画面一覧

<!-- 個別画面の詳細レイアウトは specs/<feature-name>.md に書く。ここはマスター一覧のみ。 -->

| 画面 ID | 画面名 | 説明 | 関連機能 ID |
| --- | --- | --- | --- |
| S-001 | <画面名> | <説明> | F-001 |

### 3.2 画面遷移図 — **全体設計の中核**

<!-- 画面間の遷移を図示 (テキスト or ASCII)。プロジェクト全体の画面遷移をここで一望できるように。 -->

```
[ 起動 ]
   ↓
[ ログイン画面 (S-001) ] ──成功──> [ ホーム画面 (S-002) ] ──> [ 詳細画面 (S-003) ]
   │                                     │
   │ ←──ログアウト────────────────────────┘
   │
   └──失敗──> [ ログイン画面 (エラー表示) ]
```

### 3.3 共通 UI 要素

<!-- ナビゲーション、ヘッダー、フッター、共通コンポーネント、デザインシステム -->

## 4. データ設計（全体俯瞰）

### 4.1 ER 図 (論理設計)

<!-- エンティティと関連を図示 (テキスト or ASCII)。全体のデータモデル俯瞰。 -->

```
[User] 1 --- N [Post] N --- 1 [Category]
   │
   1
   │
   N
[Session]
```

### 4.2 テーブル / コレクション一覧

<!-- テーブル/コレクションのマスター一覧。詳細な項目は specs に書く方針もあり。 -->

| テーブル ID | テーブル名 | 主な役割 | 関連機能 ID |
| --- | --- | --- | --- |
| T-001 | users | ユーザーマスタ | F-001 |
| T-002 | books | 本のレコード | F-002 |

### 4.3 データ保持方針

<!-- 保存期間、論理削除/物理削除、バックアップ頻度、退会時の扱い等 -->

## 5. API / 外部インタフェース設計（全体俯瞰）

### 5.1 内部 API 一覧

<!-- API のマスター一覧。リクエスト/レスポンスの詳細は specs に書く。 -->

| メソッド | パス | 認可 | 説明 | 関連機能 ID |
| --- | --- | --- | --- | --- |
| POST | /api/v1/auth/login | 不要 | ログイン | F-001 |
| GET | /api/v1/books | ログイン必須 | 書籍検索 | F-002 |

### 5.2 外部サービス連携

| サービス | 用途 | 認証方式 | 関連手動タスク |
| --- | --- | --- | --- |
| Firebase Auth | ユーザー認証 | API Key + Service Account | docs/manual-tasks/login-flow.md |
| | | | |

## 6. 認証・認可設計（全体方針）

### 6.1 認証方式

<!-- セッション / JWT / OAuth プロバイダ等 -->

### 6.2 認可ロール

| ロール | 権限 |
| --- | --- |
| guest | 公開コンテンツの閲覧のみ |
| user | 自分のデータの作成・更新・削除 |
| admin | 全データの管理 |

### 6.3 セッション / トークンの管理

<!-- 寿命、更新ポリシー、保存場所 (Cookie / Keychain / Keystore 等) -->

## 7. 非機能設計（全体方針）

<!--
プロジェクト全体に適用される非機能要件の実現方針。
機能固有の非機能要件は requirements/<feature-name>.md に書く。
-->

### 7.1 性能設計
<!-- キャッシュ戦略、CDN、データベースインデックス、N+1 対策等 -->

### 7.2 セキュリティ設計
<!-- HTTPS 強制、CSP、入力検証、レート制限、監査ログ等 -->

### 7.3 ログ・モニタリング
<!-- ログレベル、出力先、構造化ログ、アラート、APM 等 -->

### 7.4 アクセシビリティ実現方針
<!-- WCAG 達成のための具体的施策 -->

## 8. デプロイ・運用設計

### 8.1 環境構成

| 環境 | 用途 | URL / アクセス方法 |
| --- | --- | --- |
| development | 開発 | localhost |
| staging | 検証 | |
| production | 本番 | |

### 8.2 CI/CD パイプライン

<!-- GitHub Actions / Vercel Deploy 等。ビルド・テスト・デプロイの流れ -->

### 8.3 バックアップ・復旧

<!-- バックアップ頻度、復旧手順、RTO/RPO 等 -->

## 9. オープン課題

- [ ] <未確定項目 1>

## ステータス

<!--
- ドラフト: architect が作成中
- 確定 (YYYY-MM-DD): ユーザー承認済み
- 改訂 (YYYY-MM-DD): 全体設計が変更された (機能追加・アーキテクチャ変更 等)
-->

ドラフト
