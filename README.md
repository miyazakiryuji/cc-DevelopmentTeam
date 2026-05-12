# cc-DevelopmentTeam

> A Claude Code plugin that brings a 4-department workflow (design / develop / review / test) plus a security advisor, with automatic spec back-fill.

## このプラグインで何ができるの?

ひとことで言うと、**Claude Code で開発する作業を「会社の4部署 + 専門アドバイザー」に分担させる** プラグインです。

| 部署 | 役割 |
| --- | --- |
| architect | 設計（仕様書作成） |
| developer | 実装（コード書く） |
| reviewer | レビュー（指摘する） |
| tester | テスト（書いて実行） |
| security-reviewer | セキュリティ専門点検（追加で呼ぶ） |

このプラグインの最大の特徴は **「設計を通さずに開発した場合でも、完了時に必ず仕様書が back-fill される」** ことです。「動くものが先、仕様書は後」という現実的な進め方をしても、ナレッジが必ずリポジトリに残ります。

> **共通ルール:** 全てのコマンド・エージェントは **破壊的な変更を自動実行しません**。ビルドが壊れる可能性のあるファイル移動・削除・リネームは、必ずユーザー承認を経てから実施します。

## こんな人におすすめ

- 個人開発を始めたいけど、何から手を付ければいいか分からない人
- Claude Code に任せて作ってもらいたいけど、後で「何を作ったか分からない」状態になりたくない人
- 仕様書を書くのは面倒だけど、ドキュメントは残しておきたい人
- チーム開発のフロー（設計→実装→レビュー→テスト）を個人開発でも再現したいエンジニア

> **迷ったらまず `/cc-development-team:guide` を実行してください。** 今の状況を聞いて、次に打つコマンドを 1〜2 個に絞って案内してくれます。

---

## 30 秒インストール

```bash
cd ~/my-project
claude
```

Claude Code 内で:

```
/plugin marketplace add miyazakiryuji/cc-DevelopmentTeam
/plugin install cc-development-team@cc-development-team
/cc-development-team:init-dept
```

詳しくは [guides/quickstart.md](./guides/quickstart.md)。

---

## 主要コマンド早見表

| やりたいこと | 使うコマンド |
| --- | --- |
| 何から始めればいいか分からない | `/cc-development-team:guide` |
| アプリ案を相談したい | `/cc-development-team:brainstorm` |
| 仕様書を作る / 更新する | `/cc-development-team:architect [名前]` |
| 開発する（develop モード） | `/cc-development-team:develop [名前]` |
| テストを書く / 実行する | `/cc-development-team:test [名前]` |
| 既存コードをリファクタ | `/cc-development-team:refactor [対象]` |
| プロジェクトの状況確認 | `/cc-development-team:status` |
| リリース前総合チェック | `/cc-development-team:release-check` |
| セキュリティ点検 | `/cc-development-team:security-review [名前]` |
| 仕様書とコードの整合性 | `/cc-development-team:sync-spec [名前]` |
| プロジェクト初期セットアップ | `/cc-development-team:init-dept` |
| プラグイン更新チェック | `/cc-development-team:update` |

詳しい使い分けは [guides/commands.md](./guides/commands.md)。

---

## こんな時はこのガイドへ

| 状況 | 読むガイド |
| --- | --- |
| 最初に触ってみる | [guides/quickstart.md](./guides/quickstart.md) |
| Claude のプランで迷っている | [guides/plans.md](./guides/plans.md) |
| モバイル開発を始める | [guides/mobile-ide.md](./guides/mobile-ide.md) |
| プラグインを最新版にしたい | [guides/update.md](./guides/update.md) |
| コマンドの使い分けを知りたい | [guides/commands.md](./guides/commands.md) |
| 各部署（agent）の役割を知りたい | [guides/departments.md](./guides/departments.md) |
| 業務フローを図解で見たい | [guides/workflow.md](./guides/workflow.md) |
| プロジェクトの構成を確認したい | [guides/directory-structure.md](./guides/directory-structure.md) |
| よくある質問を見たい | [guides/faq.md](./guides/faq.md) |
| 動かない / 思った通りに動かない | [guides/troubleshooting.md](./guides/troubleshooting.md) |
| プラグイン自体を改造したい | [guides/development.md](./guides/development.md) |

---

## はじめる前に必要なもの

1. **Claude Code** がインストール済みであること
   - 公式サイト: <https://claude.com/claude-code>
   - 公式ドキュメント: <https://docs.claude.com/en/docs/claude-code/overview>
2. ターミナル（Mac の「ターミナル」、Windows の「PowerShell」など）が使えること
3. 試したいプロジェクト用のフォルダ（無ければ `mkdir my-first-app` で作ればOK）

> **Claude のプランで迷ったら** → [guides/plans.md](./guides/plans.md)
>
> **モバイル開発をするなら** → [guides/mobile-ide.md](./guides/mobile-ide.md)（専用 IDE 推奨）

---

## ライセンス

[MIT License with Attribution Requirement](./LICENSE)

- **自由に使えます**（個人 / 商用 / 業務問わず）
- **改変・再配布も OK** です
- **ただし**、フォーク・改変版・派生プラグインを公開する場合は、**元ネタがこのリポジトリであることを必ず明記** してください

### 明記の仕方（以下のいずれか 1 箇所以上で）

- 派生プロジェクトの README または主要なドキュメント
- 利用者から見える「About」「Credits」セクション
- パッケージ/プラグインのメタデータ（`plugin.json` / `package.json` の `description` など）

### 文言の例

```
このプロジェクトは miyazakiryuji の cc-DevelopmentTeam
(https://github.com/miyazakiryuji/cc-DevelopmentTeam) をベースにしています。
```

または英語:

```
Based on cc-DevelopmentTeam by miyazakiryuji
(https://github.com/miyazakiryuji/cc-DevelopmentTeam).
```

> プライベートに自分だけで使う範囲では明記しなくて構いません。あくまで **再配布・公開** する場合の要件です。
