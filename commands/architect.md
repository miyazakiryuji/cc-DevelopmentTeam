---
description: 設計部署 (architect) を呼んで仕様書を作成する（設計フェーズのみ・実装は行わない）
argument-hint: [feature-name]
---

引数: `$ARGUMENTS`

このコマンドは **設計フェーズのみ** を実行します。developer / reviewer / tester は呼び出しません。実装に進むかどうかはユーザーの判断に委ねます（実装する場合は別途、ユーザーから明示的に依頼してもらってください）。

---

## Step 0: ターゲット選択ヒアリング

**`$ARGUMENTS` が指定されている場合**:
1. `docs/specs/$ARGUMENTS.md` が **既に存在するか** を `Read` で確認
2. 存在する場合 → ユーザーに尋ねる:
   ```
   既存の仕様書 docs/specs/$ARGUMENTS.md が見つかりました!
   どうしますか?

   a) 既存の仕様書を更新する（追記・改訂）
   b) 別の新しい機能として扱う（feature-name を別のものに変える）
   ```
   - a) → `$MODE = "update-existing"`, `$TARGET = $ARGUMENTS` として保持
   - b) → `$MODE = "new"`, ユーザーに新しい feature-name を尋ねる
3. 存在しない場合 → `$MODE = "new"`, `$TARGET = $ARGUMENTS` として保持

**`$ARGUMENTS` が空の場合**: モードを勝手に決めずに以下を実施:

### Step 0-1: 進めたい内容の確認

ユーザーに尋ねる:

```
【設計コマンド — 何をしますか?】
番号で答えてくださいね!

a) アプリの全体構想から始める（まだ何を作るか整理段階）
b) 新規の機能を仕様化する（作るものは決まっている）
c) 既存の仕様書を更新する（追記・改訂したい仕様書がある）
```

### Step 0-2a: a) を選ばれた場合

`$MODE = "mode-A"` として保持。architect のモード A から呼び出す。

### Step 0-2b: b) を選ばれた場合

ユーザーに「機能の名前（kebab-case）を教えてください」と尋ね、得た feature-name を `$TARGET` に保持。
`$MODE = "new"` として保持。

### Step 0-2c: c) を選ばれた場合

`docs/specs/*.md` を `Glob` で列挙（`_template.md` 除外）。各ファイルを `Read` して以下を抽出:

- **feature-name**: ファイル名から `.md` を除いたもの
- **ステータス**: 末尾の `## ステータス:` 行から
- **概要**: `## 概要` セクションの最初の非コメント非空行（HTML コメントは除外）。約 40 文字でトランケート。記入が無ければ `(概要未記入)`

番号付きで提示:

```
更新したい仕様書を選んでください (番号または feature-name で回答):

1. login-flow      (確定 2026-05-10)   — Firebase Auth でログインする機能
2. book-search     (確定 2026-05-08)   — Google Books API で書籍検索
...
```

ユーザーが選んだ feature-name を `$TARGET` として保持。`$MODE = "update-existing"`。

---

## Step 1: 設計部署

`architect` subagent を呼び出します。`$MODE` の値で以下を伝えてください:

- **`$MODE = "mode-A"`**: 「Step 0 のモード選択は完了済み。**モード A（アプリ構想モード）** から始めてください」
- **`$MODE = "new"`**: 「Step 0 をスキップして **モード B（機能設計モード）** から開始し、`$TARGET` の **新規仕様書** を作成してください」
- **`$MODE = "update-existing"`**: 「Step 0 をスキップして **モード B** から開始し、**既存の仕様書 `docs/specs/$TARGET.md` を更新** してください。既存内容を確認したうえで、追記・改訂したい箇所をユーザーにヒアリングし、改訂履歴セクションを末尾に追記する形で更新してください」

完了条件（`$MODE` で分岐）:
- `mode-A`: `docs/vision/vision.md` と `docs/vision/roadmap.md` が作成され、**MVP リストの先頭**機能について `docs/specs/<feature-name>.md` が確定している
- `new` または `update-existing`: `docs/specs/$TARGET.md` が確定 / 更新されている（末尾に `## ステータス: 確定 (YYYY-MM-DD)` または `## ステータス: 更新 (YYYY-MM-DD)`）

> 補足: `architect` が粒度判定で Large と診断し、機能を分割した場合は、子機能ごとに仕様書を完成させてから Step 2 に進みます。

## Step 2: 設計完了報告

architect の作業が完了したら、以下をユーザーに報告して **このコマンドは終了** します。

- 作成された仕様書のパス: `docs/specs/<feature-name>.md`
- モード A の場合: `docs/vision/vision.md` と `docs/vision/roadmap.md` のパスも併記
- 仕様書の主な内容を 3〜5 行で要約
- モード A の場合: roadmap.md の残り MVP 機能を一覧表示し、「次の機能 `<次の名前>` を設計するなら `/cc-development-team:architect <次の名前>` を実行してください」と案内

**developer / reviewer / tester は呼び出さないこと。** 実装フェーズに進むかどうかはユーザーが判断します。明示的な依頼があるまで待機してください。実装に進める場合は `/cc-development-team:develop` を別途実行してください。
