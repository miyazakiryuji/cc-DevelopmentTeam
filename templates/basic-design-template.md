# <プロジェクト名> 基本設計書

<!--
このファイルは設計部署 (architect) がアプリ構想モード A で読み込むテンプレートです。
docs/basic-design/basic-design.md として書き出されます。
プロジェクト全体の「どう作るか」をシステム設計レベルで明文化したものです。
内部実装の細かなロジックは個別機能の docs/specs/<feature-name>.md に委ねます。
-->

**関連ドキュメント:**
- 要件定義書: [docs/requirements/requirements.md](../requirements/requirements.md)
- 構想: [docs/vision/vision.md](../vision/vision.md)
- 機能ロードマップ: [docs/vision/roadmap.md](../vision/roadmap.md)

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

## 2. 画面設計

### 2.1 画面一覧

| 画面 ID | 画面名 | 説明 | 関連機能 ID |
| --- | --- | --- | --- |
| S-001 | <画面名> | <説明> | F-001 |

### 2.2 画面遷移図

<!-- 画面間の遷移を図示 (テキスト or ASCII) -->

```
[ ログイン画面 ] ──成功──> [ ホーム画面 ] ──> [ 詳細画面 ]
       │
       └──失敗──> [ ログイン画面 (エラー表示) ]
```

### 2.3 共通 UI 要素

<!-- ナビゲーション、ヘッダー、フッター、共通コンポーネント、デザインシステム -->

## 3. データ設計

### 3.1 ER 図 (論理設計)

<!-- エンティティと関連を図示 (テキスト or ASCII) -->

```
[User] 1 --- N [Post] N --- 1 [Category]
```

### 3.2 テーブル / コレクション定義

#### <テーブル名 1>

| カラム | 型 | 必須 | 制約 | 説明 |
| --- | --- | --- | --- | --- |
| id | uuid | ✓ | PK | 主キー |
| created_at | timestamp | ✓ | | 作成日時 |
| updated_at | timestamp | ✓ | | 更新日時 |

### 3.3 データ保持方針

<!-- 保存期間、論理削除/物理削除、バックアップ頻度、退会時の扱い等 -->

## 4. API / 外部インタフェース設計

### 4.1 内部 API 一覧

| メソッド | パス | 認可 | 説明 | 関連機能 ID |
| --- | --- | --- | --- | --- |
| GET | /api/v1/<resource> | ログイン必須 | <説明> | F-001 |

### 4.2 外部サービス連携

| サービス | 用途 | 認証方式 | 関連手動タスク |
| --- | --- | --- | --- |
| Firebase Auth | ユーザー認証 | API Key + Service Account | docs/manual-tasks/auth.md |
| | | | |

## 5. 認証・認可設計

### 5.1 認証方式

<!-- セッション / JWT / OAuth プロバイダ等 -->

### 5.2 認可ロール

| ロール | 権限 |
| --- | --- |
| guest | 公開コンテンツの閲覧のみ |
| user | 自分のデータの作成・更新・削除 |
| admin | 全データの管理 |

### 5.3 セッション / トークンの管理

<!-- 寿命、更新ポリシー、保存場所 (Cookie / Keychain / Keystore 等) -->

## 6. 非機能設計

### 6.1 性能設計

<!-- キャッシュ戦略、CDN、データベースインデックス、N+1 対策等 -->

### 6.2 セキュリティ設計

<!-- HTTPS 強制、CSP、入力検証、レート制限、監査ログ等 (要件定義書 4.3 の実現方針) -->

### 6.3 ログ・モニタリング

<!-- ログレベル、出力先、構造化ログ、アラート、APM 等 -->

### 6.4 アクセシビリティ実現方針

<!-- WCAG 達成のための具体的施策 (要件定義書 4.6 の実現方針) -->

## 7. デプロイ・運用設計

### 7.1 環境構成

| 環境 | 用途 | URL / アクセス方法 |
| --- | --- | --- |
| development | 開発 | localhost |
| staging | 検証 | |
| production | 本番 | |

### 7.2 CI/CD パイプライン

<!-- GitHub Actions / Vercel Deploy 等。ビルド・テスト・デプロイの流れ -->

### 7.3 バックアップ・復旧

<!-- バックアップ頻度、復旧手順、RTO/RPO 等 -->

## 8. オープン課題

- [ ] <未確定項目 1>

## ステータス

<!--
- ドラフト: architect が作成中
- 確定 (YYYY-MM-DD): ユーザー承認済み
- 改訂 (YYYY-MM-DD): 設計が追加・変更された
-->

ドラフト
