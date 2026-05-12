# このプラグイン自体を改造したい開発者向け

このガイドは、プラグイン本体をフォーク・改造したい開発者向けです。

## ローカルで開発・テストする

```bash
# 別プロジェクトでローカルパス指定でロード
claude --plugin-dir /path/to/cc-DevelopmentTeam
```

## リポジトリ構成

```
cc-DevelopmentTeam/
├── .claude-plugin/
│   ├── plugin.json          # プラグイン定義
│   └── marketplace.json     # 配布用マーケットプレース定義
├── agents/                  # 5 部署 (4 + 専門アドバイザー) のサブエージェント
│   ├── architect.md
│   ├── developer.md
│   ├── reviewer.md
│   ├── tester.md
│   └── security-reviewer.md
├── commands/                # スラッシュコマンド
│   ├── guide.md
│   ├── brainstorm.md
│   ├── design.md
│   ├── develop.md
│   ├── refactor.md
│   ├── status.md
│   ├── release-check.md
│   ├── security-review.md
│   ├── sync-spec.md
│   ├── init-dept.md
│   └── update.md
├── templates/               # init-dept でユーザープロジェクトにコピーされるテンプレ
│   ├── vision-template.md
│   ├── basic-design-template.md
│   ├── requirements-template.md
│   ├── spec-template.md
│   └── manual-tasks-template.md
├── guides/                  # 日本語の手順書（このフォルダ）
│   └── ...
├── README.md                # ナビゲーター役の最小限の説明
└── LICENSE                  # MIT License with Attribution Requirement
```

各ファイルは Markdown なので、エディタで開いて編集できます。

## 改造の方針

- **コマンドの追加**: `commands/<新コマンド名>.md` を追加。frontmatter で `description` と `argument-hint` を書き、本文に処理内容を Markdown で記述
- **エージェントの追加**: `agents/<新エージェント名>.md` を追加。frontmatter で `name` / `description` / `tools` / `model` を書く
- **テンプレートの追加**: `templates/` に追加し、`commands/init-dept.md` でコピー指示を追記

## ライセンス上の注意

このプラグインは **MIT License with Attribution Requirement** です。フォーク・改変版・派生プラグインを公開する場合、元ネタが `cc-DevelopmentTeam by miyazakiryuji` であることを明記してください。詳細は [LICENSE](../LICENSE) を参照。
