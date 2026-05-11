---
description: 設計→開発→レビュー→テストの完全パイプラインを実行する（設計先行ルート）
argument-hint: [feature-name]
---

「$ARGUMENTS」を以下のフローで実装してください。

**$ARGUMENTS が空 / 未指定の場合**: モードを **勝手に決めずに** `architect` を呼び出してください。`architect` 側の Step 0 でユーザーに「A: アプリ構想モード / B: 機能設計モード」のどちらで進めるかを必ず確認させること。ここで A を選んだ場合のみ、vision/roadmap → MVP 全機能のループ実行に入ります。B を選んだ場合は、feature-name を `architect` がユーザーに尋ねてからモード B のヒアリングに入ります。

**$ARGUMENTS が指定されている場合**: feature-name が明示されているので、Step 0 を経由せず **モード B（機能設計モード）から直接開始** するよう `architect` に明示してください。

---

**重要**: 各 Step の完了時に、ユーザーに結果を報告し、承認を受けてから次に進んでください。途中スキップ・並列実行は禁止です。

## Step 1: 設計部署

`architect` subagent を呼び出します。引数の有無で以下を伝えてください:

- 引数あり: 「Step 0 をスキップしてモード B（機能設計モード）から開始し、`$ARGUMENTS` の仕様書を作成してください」
- 引数なし: 「Step 0 のモード選択（A / B）からユーザーに必ず確認してから進めてください。モードを勝手に決めないこと」

完了条件（ユーザーが選んだモードで分岐）:
- ユーザーが A（アプリ構想モード）を選んだ場合: `docs/vision/vision.md` と `docs/vision/roadmap.md` が作成され、**MVP リストの先頭**機能について `docs/specs/<feature-name>.md` が確定している
- ユーザーが B（機能設計モード）を選んだ、または引数ありで呼ばれた場合: `docs/specs/<feature-name>.md` が確定している（末尾に `## ステータス: 確定 (YYYY-MM-DD)`）

確定した `feature-name` を `$CURRENT_FEATURE` として保持してください。
**ユーザー承認なしに Step 2 に進まないこと。**

> 補足: `architect` が粒度判定で Large と診断し、機能を分割した場合は、子機能ごとに Step 1 を完了させてから Step 2 に入ります。

## Step 2: 開発部署

`developer` subagent を呼び出して、Step 1 で確定した `$CURRENT_FEATURE` の仕様書 (`docs/specs/$CURRENT_FEATURE.md`) に基づき実装してもらいます。

完了報告には以下を含めること:
- 変更したファイル一覧
- 新規依存関係を追加した場合はその理由
- 仕様書のどの章を満たしたか

## Step 3: レビュー部署

`reviewer` subagent を呼び出してセルフレビュー。
🔴 Must 指摘がある場合は `developer` に修正を依頼し、すべて解消するまで Step 3 を繰り返します。

## Step 4: テスト部署

`tester` subagent を呼び出して、仕様書の Given-When-Then をテストケースに変換し、全件パスを確認します。
既存テストが落ちた場合は `developer` に差し戻し（`tester` は既存テストを勝手に書き換えない）。

## Step 5: 完了報告

`$CURRENT_FEATURE` 1 機能分について、以下を出力してユーザーに完了を報告:

- 仕様書のパス（`docs/specs/$CURRENT_FEATURE.md`）
- アプリ構想モードを経た場合は vision.md / roadmap.md のパスも併記
- 変更したファイル一覧
- テスト結果サマリ（pass / fail 数）
- PR 本文ドラフト
  - ## 背景
  - ## 変更内容
  - ## 動作確認方法
  - ## 関連 Issue

## Step 6: MVP ループ管理（モード A から来たときのみ）

**この Step は Step 1 で「ユーザーがモード A を選んだ」場合のみ実行する。** モード B から始めた場合（引数あり、または Step 0 で B を選んだ場合）はここで終了する。

### Step 6-1: roadmap.md の進捗マーク更新

`docs/vision/roadmap.md` を `Read` で開き、`MVP` セクションの中で `$CURRENT_FEATURE` に該当する行を見つけ、`- [ ]` を `- [x]` に書き換える（`Edit` ツールを使用）。

### Step 6-2: 次の MVP 機能を特定

更新後の roadmap.md を再読し、`MVP` セクションで最初に残っている `- [ ]` 行の `feature-name` を抽出する。

### Step 6-3: 残り機能の有無で分岐

#### 残り機能がある場合

ユーザーに以下のフォーマットで確認:

```
【MVP 進捗】
完了: <完了済み機能名のリスト>
残り: <未完了機能名のリスト>

次の機能 `<次の feature-name>` に進みますか? (yes / no / skip)

- yes: そのまま次の機能の設計→実装→レビュー→テストを進めます
- no: ここで一旦終了します（後で再開する場合は `/cc-development-team:feature <feature-name>` で個別起動できます）
- skip: その機能をスキップして次の次に進みます
```

ユーザーの回答に応じて:
- **yes**: `$CURRENT_FEATURE` をその feature-name に更新し、**Step 1 に戻る**（ただし引数あり扱いでモード B 直行）。Step 1 で `architect` を呼ぶときは「Step 0 をスキップしてモード B から `<次の feature-name>` の仕様書を作成してください。roadmap.md と vision.md を参照して、暫定で 8 項目を埋めて確認してから進めてください」と伝える
- **no**: Step 7（セッション全体の完了報告）へ進む
- **skip**: roadmap.md でその機能の `- [ ]` を `- [-]` にマーク（skipped を意味する）し、その次の `- [ ]` を新しい候補にして再度 Step 6-3 の確認に戻る

#### 残り機能がない場合

「MVP 全機能の実装が完了しました!」とユーザーに報告し、Step 7 へ進む。

## Step 7: セッション完了報告（モード A の場合のみ）

MVP ループを抜けたとき、以下をユーザーに最終報告:

- アプリ名（vision.md より）
- 完了した MVP 機能一覧（`- [x]` の行）
- スキップした MVP 機能一覧（`- [-]` の行、あれば）
- 未完了の MVP 機能一覧（`- [ ]` の行、あれば）
- 全体で変更したファイル数、追加したテスト数
- 次のステップ提案:
  - 未完了機能があれば再開コマンドを案内
  - 全完了なら Phase 2 機能の検討を提案
