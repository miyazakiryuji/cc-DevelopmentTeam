# <feature-name> 詳細仕様書

<!--
このファイルは設計部署 (architect) が機能設計モード B で読み込むテンプレートです。
docs/specs/<feature-name>.md として書き出されます。

ここに書くのは **この機能の詳細仕様 (個別設計)** です。
- プロジェクト全体の構成・画面遷移・データモデル俯瞰: docs/basic-design/basic-design.md
- この機能の要件 (何を作る・なぜ作る): docs/requirements/<feature-name>.md
- この機能の詳細仕様 (どう動くか、受け入れ基準): このファイル
-->

**関連ドキュメント:**
- 構想 / ロードマップ: [docs/vision/](../vision/)
- 全体設計 (基本設計書): [docs/basic-design/basic-design.md](../basic-design/basic-design.md)
- 機能要件定義書: [docs/requirements/&lt;feature-name&gt;.md](../requirements/<feature-name>.md)

**機能 ID** (basic-design.md の機能一覧から): F-XXX

## 概要

<!-- 1〜2 文。「何のための機能か」を一言で。 -->

## 背景・目的

<!-- なぜこの機能が必要なのか。誰のどんな課題を解決するのか。 -->

## ユーザーストーリー

<!--
形式: <ユーザー> として、<目的> のために、<機能> したい
例: 一般ユーザーとして、買い物履歴を確認するために、注文一覧を表示したい
-->

## 機能要件

<!--
箇条書きで列挙。
各項目は「動詞 + 目的語」で始める。
-->

## 受け入れ基準 (Given-When-Then)

<!--
この章はテスト部署が直接テストケースに変換する重要章。
曖昧な表現を絶対に使わない。
-->

### AC-1: <ケース名>
- Given: <前提条件>
- When: <操作 / イベント>
- Then: <期待結果>

### AC-2: <ケース名>
- Given: ...
- When: ...
- Then: ...

## 非機能要件

- パフォーマンス: <例: レスポンス < 200ms>
- セキュリティ: <例: SQL injection 対策必須>
- エラーハンドリング: <例: 通信失敗時はリトライ 3 回>

## 入出力

### 入力
| 項目 | 型 | 必須 | 制約 | 備考 |
|---|---|---|---|---|

### 出力
| 項目 | 型 | 備考 |
|---|---|---|

## 影響範囲

### 変更するファイル
- <path/to/file1>: <変更理由>

### 追加するファイル
- <path/to/file2>: <追加理由>

### 触らないファイル / 機能
- <注意点>

## 手動操作タスク（外部サービス設定など）

<!--
人間が UI で操作する必要のあるタスク（Firebase / Supabase / OAuth プロバイダ / DNS 等）が
あれば docs/manual-tasks/<feature-name>.md にまとめて、ここからリンクする。
無ければ「無し」と書いておく。
-->

**関連手動タスク:** [docs/manual-tasks/&lt;feature-name&gt;.md](../manual-tasks/<feature-name>.md)

無ければ「無し」と記載。

## 範囲外

<!-- 今回は意図的にやらないこと。これを書くことで「ついで実装」を防ぐ。 -->

## オープン課題

- [ ] <未確定項目 1>

## ステータス

<!--
- ドラフト: architect が作成中
- 確定 (YYYY-MM-DD): ユーザー承認済み。developer 着手可
- back-fill (YYYY-MM-DD): develop ルートで事後生成
-->

ドラフト
