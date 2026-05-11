---
description: 設計→開発→レビュー→テストの完全パイプラインを実行する（設計先行ルート）
argument-hint: [feature-name]
---

「$ARGUMENTS」を以下のフローで実装してください。

**$ARGUMENTS が空 / 未指定の場合**: モードを **勝手に決めずに** `architect` を呼び出してください。`architect` 側の Step 0 でユーザーに「A: アプリ構想モード / B: 機能設計モード」のどちらで進めるかを必ず確認させること。ここで A を選んだ場合のみ、vision/roadmap → MVP 最初の機能の仕様化まで自動進行します。B を選んだ場合は、feature-name を `architect` がユーザーに尋ねてからモード B のヒアリングに入ります。

**$ARGUMENTS が指定されている場合**: feature-name が明示されているので、Step 0 を経由せず **モード B（機能設計モード）から直接開始** するよう `architect` に明示してください。

---

**重要**: 各 Step の完了時に、ユーザーに結果を報告し、承認を受けてから次に進んでください。途中スキップ・並列実行は禁止です。

## Step 1: 設計部署

`architect` subagent を呼び出します。引数の有無で以下を伝えてください:

- 引数あり: 「Step 0 をスキップしてモード B（機能設計モード）から開始し、`$ARGUMENTS` の仕様書を作成してください」
- 引数なし: 「Step 0 のモード選択（A / B）からユーザーに必ず確認してから進めてください。モードを勝手に決めないこと。A を選ばれた場合は MVP 最初の機能の仕様化までを 1 セッションで完了させること」

完了条件（ユーザーが選んだモードで分岐）:
- ユーザーが A（アプリ構想モード）を選んだ場合: `docs/vision/vision.md` と `docs/vision/roadmap.md` が作成され、MVP の 1 機能目について `docs/specs/<feature-name>.md` が確定している
- ユーザーが B（機能設計モード）を選んだ、または引数ありで呼ばれた場合: `docs/specs/<feature-name>.md` が確定している（末尾に `## ステータス: 確定 (YYYY-MM-DD)`）

**ユーザー承認なしに Step 2 に進まないこと。**

> 補足: `architect` が粒度判定で Large と診断し、機能を分割した場合は、子機能ごとに Step 1 を完了させてから Step 2 に入ります。

## Step 2: 開発部署

`developer` subagent を呼び出して、Step 1 で確定した仕様書に基づき実装してもらいます。

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

以下を出力してユーザーに完了を報告:

- 仕様書のパス（`docs/specs/<feature-name>.md`）
- アプリ構想モードを経た場合は vision.md / roadmap.md のパスも併記
- 変更したファイル一覧
- テスト結果サマリ（pass / fail 数）
- PR 本文ドラフト
  - ## 背景
  - ## 変更内容
  - ## 動作確認方法
  - ## 関連 Issue
- **次のアクション提案**: roadmap.md に残っている MVP 機能があれば「次は `<次の機能名>` を `/cc-development-team:feature <次の機能名>` で進めますか?」と提案
