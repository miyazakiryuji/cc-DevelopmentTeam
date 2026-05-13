# トラブルシューティング

「動かない」「思った通りに動かない」時はここを順に確認してください。

> **まず最初に `/cc-development-team:doctor` を実行** してください。プラグイン / プロジェクト初期化状態を自動診断して、何が足りないかを ✓/✗ で表示してくれます。

## `/plugin marketplace add` で失敗する

- ネットワーク接続を確認してください
- GitHub にアクセスできる環境か確認してください（社内ネットワーク等で制限されている場合あり）
- リポジトリ名のスペルミスを確認 (`miyazakiryuji/cc-DevelopmentTeam`)

## `/cc-development-team:init-dept` を実行しても何も起きない / 古い挙動のまま

- プラグインが正しくインストールされているか `/plugin list` で確認してください
- [update.md](./update.md) の手順を参照し、`/plugin marketplace update` と再インストールを実行してください
- Claude Code を再起動してみてください（更新後は再起動推奨）

## サブエージェントが期待通りに動かない

- 設計部署は `docs/dept/architect/CLAUDE.md`、その他 3 部署は `dept/<部署名>/CLAUDE.md` の中身を見直し、矛盾した指示が無いか確認してください
- ルートの `CLAUDE.md` と部署別の `CLAUDE.md` で矛盾がないか確認してください

## 「develop モード」から抜けたい / 抜けられない

- 「終了」「終わり」「もう大丈夫」のどれかを伝えてください
- それでも抜けられない場合は他のスラッシュコマンド（例: `/cc-development-team:architect`）を実行すると自動的にモードが切れます

## それでも解決しない場合

- GitHub Issue (<https://github.com/miyazakiryuji/cc-DevelopmentTeam/issues>) で報告してください
- 再現手順 / 期待する挙動 / 実際の挙動 / Claude Code のバージョン を添えてもらえると対応しやすいです
