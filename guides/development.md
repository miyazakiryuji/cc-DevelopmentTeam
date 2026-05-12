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
│   ├── architect.md         # 主ファイル (薄い: Step 0 + モード別 Read 指示)
│   ├── developer.md         # 主ファイル (薄い: フロー + Frontend Skills 表 + docstring 言語表)
│   ├── reviewer.md
│   ├── tester.md
│   └── security-reviewer.md
├── commands/                # スラッシュコマンド
│   ├── guide.md
│   ├── brainstorm.md
│   ├── architect.md         # 設計コマンド (旧 design.md からリネーム)
│   ├── develop.md
│   ├── test.md
│   ├── refactor.md
│   ├── status.md
│   ├── release-check.md
│   ├── security-review.md
│   ├── sync-spec.md
│   ├── init-dept.md
│   └── update.md            # GitHub と照合して最新かチェック
├── templates/               # init-dept で配置するテンプレ + 各 agent/command が必要時に Read する参照ファイル
│   ├── vision-template.md
│   ├── basic-design-template.md
│   ├── requirements-template.md
│   ├── spec-template.md
│   ├── manual-tasks-template.md
│   ├── init-welcome-guide.md          # init-dept 完了時に表示する使い方ガイド
│   ├── architect/                     # architect のモード詳細
│   │   ├── mode-a-vision.md           # アプリ構想モード A-1〜A-5
│   │   └── mode-b-feature.md          # 機能設計モード B-1〜B-5 (章ごと対話)
│   ├── dept-claude-md/                # 部署別 CLAUDE.md (Web/Mobile × 5 部署 = 10 ファイル)
│   │   ├── architect-web.md / architect-mobile.md
│   │   ├── developer-web.md / developer-mobile.md
│   │   ├── reviewer-web.md / reviewer-mobile.md
│   │   ├── tester-web.md / tester-mobile.md
│   │   └── security-reviewer-web.md / security-reviewer-mobile.md
│   ├── develop/
│   │   └── mock-launch-commands.md    # Web/iOS/Android/Flutter/RN 別の起動コマンド
│   └── doc-comments/                  # 19 言語の docstring 例 (developer が必要時に Read)
│       ├── typescript.md / python.md / swift.md / kotlin.md / go.md
│       ├── rust.md / dart.md / java.md / csharp.md / ruby.md
│       ├── php.md / c-cpp.md / elixir.md / scala.md / bash.md
│       └── sql.md / haskell.md / r.md / lua.md
├── guides/                  # 日本語の手順書（このフォルダ）
│   └── ...
├── README.md                # ナビゲーター役の最小限の説明
└── LICENSE                  # MIT License with Attribution Requirement
```

各ファイルは Markdown なので、エディタで開いて編集できます。

## 設計思想: 主ファイルは薄く、詳細は必要時に Read

`agents/` と `commands/` の主ファイルは **フロー制御だけ** を担当し、詳細データ (テンプレート / 言語別フォーマット / モード詳細など) は `templates/` 配下に配置して、**そのステップに到達した瞬間に Read** で取りに行く設計です。主ファイルだけ読んでも動作は変わらず、不要な詳細でコンテキストを消費しません。

ファイル行数の目安: 主ファイルは 300 行前後、それを超えるなら詳細を `templates/` に分離します。

## 改造の方針

- **コマンドの追加**: `commands/<新コマンド名>.md` を追加。frontmatter で `description` と `argument-hint` を書き、本文に処理内容を Markdown で記述
- **エージェントの追加**: `agents/<新エージェント名>.md` を追加。frontmatter で `name` / `description` / `tools` / `model` を書く
- **テンプレート / 参照ファイルの追加**: `templates/<カテゴリ>/<新ファイル>.md` に追加。主ファイルからは「必要になった瞬間に `${CLAUDE_PLUGIN_ROOT}/templates/<path>` を Read する」形で参照する

## ライセンス上の注意

このプラグインは **MIT License with Attribution Requirement** です。フォーク・改変版・派生プラグインを公開する場合、元ネタが `cc-DevelopmentTeam by miyazakiryuji` であることを明記してください。詳細は [LICENSE](../LICENSE) を参照。
