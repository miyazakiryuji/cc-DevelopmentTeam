# cc-DevelopmentTeam — プラグイン本体の開発ルール

このファイルは **このプラグイン自体を改造するときの作業ルール** です。
（ユーザープロジェクト側で `/cc-development-team:init-dept` が作る `CLAUDE.md` とは別物です）

Claude Code がこのリポジトリで作業するときは、このファイルを必ず読んでルールに従ってください。

---

## 必須: ドキュメント整合性チェック（変更を加えるたびに実施）

コード（`agents/*.md` / `commands/*.md` / `templates/**`）に変更を加えたら、**コミット前に必ず以下のドキュメントの整合性を点検** してください。漏れたまま push されると、ユーザーが見るドキュメントと実挙動がズレます。

### 点検対象（変更内容に応じて該当箇所を更新）

| 変更タイプ | 必ず見るドキュメント |
| --- | --- |
| コマンドを追加 / 削除 / リネーム | `README.md` の主要コマンド早見表 / `guides/commands.md` / `commands/guide.md` / `guides/workflow.md` / `commands/init-dept.md` の CLAUDE.md テンプレ部 / `guides/development.md` のリポジトリ構成 |
| エージェントを追加 / 削除 / 振る舞い変更 | `guides/departments.md` / `guides/workflow.md` / `guides/faq.md` / `guides/development.md` |
| init-dept の挙動変更 (ヒアリング項目 / 生成ファイル 等) | `guides/quickstart.md` / `guides/directory-structure.md` / `guides/faq.md` |
| 仕様書 / 要件定義 / 基本設計テンプレ の章立て変更 | `guides/workflow.md` / `guides/directory-structure.md` |
| 設計思想・破壊的変更禁止・対話形式などの **全体方針** 追加 | `README.md` 冒頭 / `guides/faq.md` / 該当 agent の「やってはいけないこと」 |
| 言語別 docstring の追加 / 削除 | `agents/developer.md` の言語表 / `templates/doc-comments/<lang>.md` |
| `templates/` 配下に新規ファイル追加 | `guides/development.md` のリポジトリ構成図 |
| `/update` で確認できる旨が変わる | `guides/update.md` / `README.md` / `guides/faq.md` |

### 点検フロー

1. 変更したファイルを stage する前に、以下のコマンドで stale な参照を grep する:

   ```bash
   # コマンド名 / エージェント名 / ファイルパス で grep
   grep -rn "<変更前の名前>" --include="*.md"
   grep -rn "<削除したコマンド>" --include="*.md"
   ```

2. ヒットしたファイルを 1 つずつ確認して更新する。
3. 構成図（`guides/directory-structure.md`、`guides/development.md`）にファイル名が書かれているか確認。
4. README の早見表（コマンド一覧）と FAQ にも反映漏れが無いか確認。

### コミット前の最終チェックリスト

- [ ] 影響を受けるすべてのドキュメントを更新したか?
- [ ] 構成図（`directory-structure.md` / `development.md`）の最新化は OK か?
- [ ] FAQ に新規 Q として追加すべき話題はないか?
- [ ] README の早見表に反映漏れはないか?
- [ ] `grep -rn` で stale な参照（旧コマンド名 / 削除したファイル）がゼロ件か?

---

## 設計方針

### 1. 主ファイルは薄く、詳細は必要時に Read

`agents/` と `commands/` の主ファイルは **フロー制御だけ** を担当します。詳細データ（テンプレート / 言語別フォーマット / モード詳細など）は `templates/` 配下に配置し、**そのステップに到達した瞬間に Read** で取りに行く設計です。

- 主ファイルの行数目安: **300 行前後**
- 超えそうなら詳細を `templates/<カテゴリ>/<ファイル>.md` に分離し、主ファイルから「必要になったら Read」と指示する
- 主ファイルだけ読んでも動作が変わらないように、フロー制御は完全に主ファイル側に残す

### 2. 破壊的な変更は絶対に自動実行しない

ビルド / 既存テスト / 動作確認が通らなくなる可能性のある変更（import 書き換えを伴うファイル移動・削除・リネーム、ビルド設定変更、エントリポイントの移動など）は **ユーザー承認を経てから** 実施する。これは **全エージェント / 全コマンドの共通ルール** で、各 agent の「やってはいけないこと」と、init-dept が生成する `CLAUDE.md` テンプレにも明記しています。

### 3. ヒアリングは選択肢提示、自由記述は最後の手段

ユーザーに自由記述させると言語化負担が大きいため、`/architect` の B-1 や `init-dept` の各ヒアリングは **こちらから 3〜4 個の候補を提示** し、最後の選択肢に「その他 (自分で指定)」を置く形にしています。「お任せ (推奨)」を必ず先頭に置いて、決められないユーザーが即進めるようにしてください。

### 4. 設計フェーズの対話は章ごと

`agents/architect.md` の B-3 (要件定義書) / B-4 (詳細仕様書) は **1 章ずつドラフト提示 → 承認 → 次の章** の流れにしています。全章承認後に初めてファイルに書き出します（途中で勝手にファイルを書かない）。新しい設計ドキュメントを追加する場合も、この対話パターンに合わせてください。

---

## リポジトリ構成（変更時は `guides/development.md` も更新）

詳細は [guides/development.md](./guides/development.md) を参照。要点だけ:

```
.claude-plugin/    # plugin.json / marketplace.json
agents/            # 5 部署のサブエージェント (主ファイル)
commands/          # スラッシュコマンド (主ファイル)
templates/         # init-dept が配置するテンプレ + 主ファイルが必要時に Read する参照
  ├── architect/        # architect のモード詳細
  ├── dept-claude-md/   # 部署別 CLAUDE.md (Web/Mobile × 5 部署)
  ├── develop/          # develop のモック起動コマンド
  └── doc-comments/     # 19 言語の docstring 例
guides/            # 日本語の手順書
README.md          # ユーザー向けナビゲーター
LICENSE            # MIT + Attribution Requirement
```

---

## リリースプロセス (バージョンタグの切り方)

`/cc-development-team:update` はタグベースで比較するので、以下の手順でリリースを切ります。

### 1. 変更を `CHANGELOG.md` の `[Unreleased]` セクションに書き溜める

各コミット直後、CHANGELOG.md の `## [Unreleased]` 配下に Added / Changed / Fixed / Removed のいずれかで追記しておく。

### 2. リリース時の手順

1. `[Unreleased]` の内容を確定バージョンに移動:
   ```markdown
   ## [Unreleased]

   ## [1.2.0] - 2026-06-01
   <!-- 旧 Unreleased 配下の内容を移動 -->
   ```
2. `.claude-plugin/plugin.json` の `version` を新バージョンに更新 (例: `"version": "1.2.0"`)
3. CHANGELOG.md 末尾のリンク参照も更新:
   ```markdown
   [Unreleased]: https://github.com/miyazakiryuji/cc-DevelopmentTeam/compare/v1.2.0...HEAD
   [1.2.0]: https://github.com/miyazakiryuji/cc-DevelopmentTeam/releases/tag/v1.2.0
   ```
4. コミット & タグ push:
   ```bash
   git commit -am "chore: release v1.2.0"
   git tag v1.2.0
   git push origin main --tags
   ```
5. GitHub 上で Release を作成 (gh CLI でもブラウザでも):
   ```bash
   gh release create v1.2.0 \
     --title "v1.2.0" \
     --notes "$(awk '/^## \[1.2.0\]/{flag=1; next} /^## \[/{flag=0} flag' CHANGELOG.md)"
   ```

### 3. Semantic Versioning に従う

- **MAJOR (x.0.0)**: 破壊的変更 (コマンド削除 / 引数の意味変更 / フォルダ構造変更 等)
- **MINOR (0.x.0)**: 機能追加 (後方互換あり)
- **PATCH (0.0.x)**: バグ修正のみ

### 4. v1.0.0 を切るまでは 0.x.y で運用

機能セットが安定し、API (コマンド名・引数・出力フォーマット) を固定できる確信が持てたら v1.0.0 を切る。それまでは 0.x で破壊的変更も自由。

---

## コミットメッセージの方針

- 日本語で要約 → 詳細を箇条書きで
- 種別: `feat:` / `fix:` / `refactor:` / `docs:` / `chore:`
- 1 コミット 1 トピック。複数の意味のある変更は分割
- 末尾に `Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>`

例:
```
feat(develop): サイクル範囲 (full/lean) をモード開始時にヒアリング

「1 サイクル丸ごと回すか、テストを切り離すか」をユーザーに選ばせる方式に変更。

- develop モード開始時に $CYCLE_MODE を必ずヒアリング
- ...
```

---

## ライセンス

MIT License with Attribution Requirement (詳細は [LICENSE](./LICENSE))。
フォーク・改変版・派生プラグインを公開する場合、元ネタが `cc-DevelopmentTeam by miyazakiryuji` であることを明記してください。
