---
description: cc-DevelopmentTeam プラグインを使い始めるためにプロジェクト側を初期化する
---

このプロジェクトを 4 部署フローで運用するために、以下を順に実行してください。

1. `docs/specs/` ディレクトリを作成する（既に存在する場合はスキップ）
2. プロジェクトルートに `CLAUDE.md` が無ければ作成する
3. `CLAUDE.md` の末尾に、以下のセクションが無ければ追記する:

   ## 4部署フロー（cc-development-team プラグイン）

   このプロジェクトは設計/開発/レビュー/テストの4部署体制で運用します。

   - 設計先行: `/cc-development-team:feature <name>`
   - 開発先行（back-fill 付き）: `/cc-development-team:develop <name>`
   - 整合性チェック: `/cc-development-team:sync-spec`

   仕様書は `docs/specs/<feature-name>.md` に集約します。
   設計部署を通さずに実装した場合は、`/cc-development-team:develop` フローの末尾で必ず仕様書が逆同期されます。

4. 完了後、利用可能なコマンド一覧をユーザーに案内する。
