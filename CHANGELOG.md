# Changelog

このプロジェクトの全ての顕著な変更はこのファイルに記録されます。

形式は [Keep a Changelog](https://keepachangelog.com/ja/1.1.0/) に従い、
バージョニングは [Semantic Versioning](https://semver.org/lang/ja/) に従います。

---

## [Unreleased]

### Added
- `examples/todo-app-web/` を追加: ドキュメント書き方の見本となるサンプルプロジェクト (Web + Feature-based + `src/`)。vision / roadmap / basic-design / requirements / specs / manual-tasks をフルセット
- `CHANGELOG.md` を追加: Keep a Changelog 形式のリリース履歴
- `README.en.md` を追加: 英語版のリポジトリ案内 (国際ユーザー向け)

### Changed
- Mobile プロジェクトでは **専用 IDE 起動を強く推奨** する運用に変更
  - `init-dept` で Mobile を選ぶと、最初に「IDE でプロジェクト作成済みか?」を確認。未作成なら init-dept を一旦止めて IDE 案内
  - `/cc-development-team:develop` の Step 5 (動作確認) でも Mobile は IDE 起動手順を案内。CLI 起動はユーザーが「CLI で起動して」と明示した場合の最終手段に
  - Web は従来通りローカル dev server で起動
  - `guides/mobile-ide.md` も IDE 主導の運用方針を明文化

---

## 既存到達点 (Unreleased 以前)

タグ運用は当面行わないため、ここまで積み上がった機能を参考までに列挙します。今後 Unreleased セクションに新規変更を書き溜めていきます。

### 主要機能 (Core)

- **5 部署体制**: architect / developer / reviewer / tester + security-reviewer (専門アドバイザー)
- **12 コマンド**: `guide` / `brainstorm` / `architect` / `develop` / `test` / `refactor` / `status` / `release-check` / `security-review` / `sync-spec` / `init-dept` / `update`
- **3 段ドキュメント階層**: vision/roadmap (構想) → basic-design (全体設計) → requirements + specs (機能ごと)
- **手動タスク追跡**: `docs/manual-tasks/<feature>.md` + ソースコードの `// TODO(manual):` で外部サービス設定漏れを防止
- **逆同期 (back-fill)**: develop モードで仕様書なし実装した場合、完了時に自動で仕様書を生成

### Added (主要な追加)

- `/cc-development-team:guide` 対話型ガイド (迷ったら最初に打つコマンド)
- `/cc-development-team:brainstorm` アプリ案ブレスト (雑談 → 3〜5 案提案)
- `/cc-development-team:architect` 設計コマンド (旧 `/design` からリネーム)
  - モード A: アプリ構想 → vision / roadmap / basic-design / MVP 先頭機能の requirements + specs
  - モード B: 機能設計 → 8 項目ヒアリング → 章ごと対話形式で requirements / specs を生成
  - モード C: 逆同期 (develop 完了後)
- `/cc-development-team:develop` 開発モード
  - サイクル範囲ヒアリング (`full` / `lean`) でテストを含めるか選択
  - 動作確認 (dev server / シミュレータ起動) もユーザー承認後に実施
- `/cc-development-team:test` テスト専用コマンド (develop と分離)
  - 失敗 / 改善は **必ずユーザー承認後** に修正適用
- `/cc-development-team:refactor` リファクタ専用 (テスト Before/After 厳守)
- `/cc-development-team:status` 現状ダッシュボード (進捗 / 残タスク / 次のオススメ)
- `/cc-development-team:release-check` リリース前総合チェック + リリースノート自動生成
  - 内部で `/test` と `/sync-spec` に委譲する薄いオーケストレーター
- `/cc-development-team:security-review` セキュリティ専門点検
- `/cc-development-team:sync-spec` 仕様書とコードのドリフト点検
- `/cc-development-team:update` 更新チェック (GitHub と照合 → 必要なら手順表示)
- `/cc-development-team:init-dept` 初期化
  - プロジェクト種別 / 設計思想 / アプリコード配置 の 3 ヒアリング
  - 既存ファイルがあれば再配置を提案 (破壊的な移動は自動実行しない)
- 関数 docstring の 19 言語フォーマット (`templates/doc-comments/`)
  - TypeScript / Python / Swift / Kotlin / Go / Rust / Dart / Java / C# / Ruby / PHP / C/C++ / Elixir / Scala / Bash / SQL / Haskell / R / Lua
- UI 実装時に Frontend Skills 連携 (Web / iOS / Android/KMP)
- デザイン素材置き場 `design/` を初期化時に作成

### Changed (重要な変更)

- 主ファイル (`agents/` / `commands/`) を 300 行前後に薄型化、詳細は `templates/` 配下から **必要時に Read** する設計に移行 (コンテキスト消費を削減)
- README をルート 1 つに限定、詳細は `guides/` 配下に分割
- `/cc-development-team:design` → `/cc-development-team:architect` にリネーム (UI design フォルダとの混同回避)

### Convention (運用ルール)

- **破壊的な変更は絶対に自動実行しない**: import 書き換えを伴うファイル移動 / ビルド設定変更 / エントリポイント移動などは必ずユーザー承認を経る (全エージェント / 全コマンド共通)
- **ヒアリングは選択肢提示**: 自由記述ではなく 3〜4 個の候補から選ぶ。「お任せ (推奨)」を必ず先頭に
- **対話形式で章ごと**: 要件定義書 / 詳細仕様書は 1 章ずつドラフト提示 → 承認 → 次の章

---

[Unreleased]: https://github.com/miyazakiryuji/cc-DevelopmentTeam/commits/main
