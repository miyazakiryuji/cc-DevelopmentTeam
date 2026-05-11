---
description: 設計部署 (architect) を呼んで仕様書を作成する（設計フェーズのみ・実装は行わない）
argument-hint: [feature-name]
---

「$ARGUMENTS」の **仕様書だけ** を作成します。

**重要**: このコマンドは **設計フェーズのみ** を実行します。developer / reviewer / tester は呼び出しません。実装に進むかどうかはユーザーの判断に委ねます（実装する場合は別途、ユーザーから明示的に依頼してもらってください）。

---

**$ARGUMENTS が空 / 未指定の場合**: モードを **勝手に決めずに** `architect` を呼び出してください。`architect` 側の Step 0 でユーザーに「A: アプリ構想モード / B: 機能設計モード」のどちらで進めるかを必ず確認させること。

**$ARGUMENTS が指定されている場合**: feature-name が明示されているので、Step 0 を経由せず **モード B（機能設計モード）から直接開始** するよう `architect` に明示してください。

---

## Step 1: 設計部署

`architect` subagent を呼び出します。引数の有無で以下を伝えてください:

- 引数あり: 「Step 0 をスキップしてモード B（機能設計モード）から開始し、`$ARGUMENTS` の仕様書を作成してください」
- 引数なし: 「Step 0 のモード選択（A / B）からユーザーに必ず確認してから進めてください。モードを勝手に決めないこと」

完了条件（ユーザーが選んだモードで分岐）:
- ユーザーが A（アプリ構想モード）を選んだ場合: `docs/vision/vision.md` と `docs/vision/roadmap.md` が作成され、**MVP リストの先頭**機能について `docs/specs/<feature-name>.md` が確定している
- ユーザーが B（機能設計モード）を選んだ、または引数ありで呼ばれた場合: `docs/specs/<feature-name>.md` が確定している（末尾に `## ステータス: 確定 (YYYY-MM-DD)`）

> 補足: `architect` が粒度判定で Large と診断し、機能を分割した場合は、子機能ごとに仕様書を完成させてから Step 2 に進みます。

## Step 2: 設計完了報告

architect の作業が完了したら、以下をユーザーに報告して **このコマンドは終了** します。

- 作成された仕様書のパス: `docs/specs/<feature-name>.md`
- モード A の場合: `docs/vision/vision.md` と `docs/vision/roadmap.md` のパスも併記
- 仕様書の主な内容を 3〜5 行で要約
- モード A の場合: roadmap.md の残り MVP 機能を一覧表示し、「次の機能 `<次の名前>` を設計するなら `/cc-development-team:feature <次の名前>` を実行してください」と案内

**developer / reviewer / tester は呼び出さないこと。** 実装フェーズに進むかどうかはユーザーが判断します。明示的な依頼があるまで待機してください。

> 注: 以前のバージョンでは本コマンドが `architect → developer → reviewer → tester` の完全パイプラインを実行していましたが、現在は **設計フェーズのみ** に縮小されています（一旦の運用方針）。将来的に実装フェーズを再連結する可能性はあります。
