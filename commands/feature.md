---
description: 設計→開発→レビュー→テストの完全パイプラインを実行する（設計先行ルート）
argument-hint: [feature-name]
---

「$ARGUMENTS」を以下のフローで実装してください。

**$ARGUMENTS が空 / 未指定の場合**: ユーザーは「まだ作るものが決まっていない」状態である可能性が高いです。Step 1 で `architect` を呼ぶ際、アプリ構想モード（モード A）から始めるよう明示的に指示してください。`architect` がアプリ構想を整理し、MVP の最初の機能まで自動で導いてくれます。

**$ARGUMENTS が指定されている場合**: 機能設計モード（モード B）から始めるよう `architect` に明示してください。

---

**重要**: 各 Step の完了時に、ユーザーに結果を報告し、承認を受けてから次に進んでください。途中スキップ・並列実行は禁止です。

## Step 1: 設計部署

`architect` subagent を呼び出します。引数の有無で以下を伝えてください:

- 引数あり: 「機能設計モード（モード B）で `$ARGUMENTS` の仕様書を作成してください」
- 引数なし: 「アプリ構想モード（モード A）から始めてください。vision と roadmap を作ったあと、MVP の最初の機能を機能設計モードで仕様書化するところまでお願いします」

完了条件:
- 引数なしのケース: `docs/vision/vision.md` と `docs/vision/roadmap.md` が作成され、MVP の 1 機能目について `docs/specs/<feature-name>.md` が確定している
- 引数ありのケース: `docs/specs/<feature-name>.md` が確定している（末尾に `## ステータス: 確定 (YYYY-MM-DD)`）

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
