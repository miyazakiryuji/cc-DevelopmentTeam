# todo-app-web (サンプル) — プロジェクト全体ルール

<!-- このファイルは examples/ 配下のサンプルです。実プロジェクトでは init-dept が生成します。 -->

## 4部署フロー（cc-development-team プラグイン）

**プロジェクト種別:** Web
**設計思想:** Feature-based + 軽量レイヤ分け (お任せ・推奨)
**アプリコード配置:** src/

このプロジェクトは設計/開発/レビュー/テストの4部署 + セキュリティ専門アドバイザー の体制で運用します。
新規ファイルを追加する際は、上記の「設計思想」と「アプリコード配置」に従ったフォルダに配置してください。

### 共通ルール: 破壊的な変更は絶対にしない

このプロジェクトで動く **全エージェント / 全コマンドに共通** のルール:

- ビルド / 既存テスト / 動作確認が通らなくなる可能性がある変更 (import 書き換えを伴うファイル移動・削除・リネーム、ビルド設定変更、エントリポイントの移動 等) を **自動実行しない**
- 必ずユーザー承認を取り、承認された範囲のみ実施
- 「念のため」「とりあえず」での移動 / 削除 / リネームは禁止。明確に安全と確認できるもののみ
- 不確実な場合は提案にとどめ、`docs/manual-tasks/` に書き出して手動対応に回す

### 主要コマンド

- 何から始めればいいか分からない: `/cc-development-team:guide`（迷ったらこれ）
- アプリ案を相談: `/cc-development-team:brainstorm`
- 仕様書を作成 / 更新: `/cc-development-team:architect [name]`
- 開発（develop モード）: `/cc-development-team:develop [name]`
- テストを書く / 実行: `/cc-development-team:test [name]`
- リファクタ専用: `/cc-development-team:refactor [対象]`
- 現状確認ダッシュボード: `/cc-development-team:status`
- リリース前総合チェック: `/cc-development-team:release-check`
- セキュリティ点検: `/cc-development-team:security-review [name]`
- 仕様書とコードの整合性: `/cc-development-team:sync-spec [name]`
- プラグイン更新手順: `/cc-development-team:update`

仕様書は `docs/specs/<feature-name>.md` に集約します。
設計部署を通さずに実装した場合は、`/cc-development-team:develop` フローの末尾で必ず仕様書が逆同期されます。

部署ごとのプロジェクト固有メモは以下に置きます。各サブエージェントは起動時に自分の CLAUDE.md を読みます。

- 設計部署: `docs/dept/architect/CLAUDE.md`（ドキュメント側）
- 開発部署: `dept/developer/CLAUDE.md`（実作業側）
- レビュー部署: `dept/reviewer/CLAUDE.md`（実作業側）
- テスト部署: `dept/tester/CLAUDE.md`（実作業側）
- セキュリティレビュー部署: `dept/security-reviewer/CLAUDE.md`（実作業側・専門アドバイザー）

セキュリティ専門の点検は `/cc-development-team:security-review` で呼び出せます。
