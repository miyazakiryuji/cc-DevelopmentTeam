# 業務フロー（図解）

このガイドでは、主要な業務フローを図解で説明します。

## 「何を作るか決まってない」から始める — `/cc-development-team:brainstorm`

```
[あなた] /cc-development-team:brainstorm を実行
   ↓
[Claude] 「最近気になってることありますか?」など雑談ベースでヒアリング (1 問ずつ)
   ↓ (3〜5 往復)
[Claude] 「ここまでの話からこんな案が浮かびました」 → アプリ案を 3〜5 個提案
   ↓ (気に入らなければ「別の方向で」と返す → 再提案ループ)
[あなた] 「これにしようかな」 → 案 1 つに決定
   ↓
[Claude] 「次は設計に進みましょう」 → /cc-development-team:architect の起動を促す
   ↓
（以降は「アプリ構想から始める」フローへ続く）
```

「作りたいものがある人」は brainstorm をスキップして直接 `/cc-development-team:architect` から始めて OK です。

## アプリ構想から始める場合 — `/cc-development-team:architect`（引数なし）

```
[あなた] /cc-development-team:architect を実行
   ↓
[architect] モード選択を確認（A: 構想 / B: 機能）
   ↓ (A を選択)
[architect] アプリ構想モードでヒアリング（1 問ずつ）→ vision.md 生成
   ↓
[architect] 機能候補を MVP / Phase 2 / Future に分類 → roadmap.md 生成
   ↓ （MVP 全体で OK か確認）
[architect] 基本設計書（全体設計）を生成 → docs/basic-design/basic-design.md 確定
   ↓ （内容を確認 → OK 出す）
[architect] MVP 先頭機能の要件定義書を作成 → docs/requirements/<feature-1>.md 確定
   ↓ （内容を確認 → OK 出す）
[architect] MVP 先頭機能の詳細仕様書を作成 → docs/specs/<feature-1>.md 確定
   ↓
完了報告。ここで停止します。
   ↓
（次の MVP 機能を設計するには `/cc-development-team:architect <feature-2>` を実行）
（実装に進むには、ユーザーから developer サブエージェントに依頼）
```

1 回の `/cc-development-team:architect` 実行で、`vision.md` → `roadmap.md` → `basic-design.md`（全体設計） → **MVP の最初の 1 機能の `requirements/<feature>.md` + `specs/<feature>.md`** まで作って停止します。実装には進みません。残りの MVP 機能を設計したい場合は、その都度 `/cc-development-team:architect <feature-name>` を実行してください。

> **「全体設計」と「個別設計」を分けるドキュメント構成:**
>
> **全体設計（プロジェクト全体で 1 ファイル）**
> - `vision.md` — 構想・動機・ターゲット
> - `roadmap.md` — 機能ロードマップ (MVP / Phase 2 / Future)
> - `basic-design.md` — 機能一覧 (F-XXX マスター) + 採用技術 + 画面遷移図 + ER 図 + API 一覧 + 認証認可方針
>
> **個別設計（機能ごとに 1 ファイル）**
> - `requirements/<機能名>.md` — この機能の目的・業務フロー・操作シナリオ・機能固有の非機能要件
> - `specs/<機能名>.md` — この機能の画面レイアウト・API 詳細・内部ロジック・受け入れ基準 (Given-When-Then)
>
> 各機能の要件定義書と詳細仕様書は、基本設計書の機能 ID (F-XXX) と紐づきます。「この機能は何の要件から来てるんだっけ?」「全体として整合してる?」を辿れる構造です。

## 設計先行ルート — `/cc-development-team:architect <名前>`

```
[あなた] 「ログイン機能の仕様書作って」 (例: /cc-development-team:architect login-flow)
   ↓
[architect] 仕様書を書く → docs/specs/login-flow.md
   ↓
完了報告。ここで停止します。
   ↓
（実装に進むかはユーザーの判断。発注したい場合は developer サブエージェントに直接依頼）
```

設計フェーズのみで停止します。developer / reviewer / tester は呼びません。実装に進める場合は `/cc-development-team:develop` を別途実行してください。

## 開発先行モード — `/cc-development-team:develop`

`/cc-development-team:develop` を実行すると **develop モード** に入り、明示的に終了するまで連続して開発依頼を処理し続けます。

```
[あなた] /cc-development-team:develop を実行（引数あり/なしどちらでも可）
   ↓
[develop モード開始]
   ↓
[Claude]  サイクル範囲をヒアリング ($CYCLE_MODE)
          a) フルサイクル (tester あり)  b) 実装重視 (tester なし)
   ↓
[あなた] 「ログイン機能作って」
   ↓
[Claude]  feature-name を確認 → docs/specs/login-flow.md の有無を判定
   ↓
[developer] 仕様書ありなら沿って実装 / 無ければ依頼から実装
   ↓
[reviewer]  品質・セキュリティ・(仕様書ありなら)整合性を点検（Approve まで反復）
   ↓
[tester]   ($CYCLE_MODE=full のときのみ) テスト作成 + 全体実行。失敗あれば修正可否をユーザー確認
   ↓
[architect] 必要時のみ仕様書を新規作成/更新（仕様書外の追加機能があった場合）
   ↓
[Claude]   動作確認の起動を確認（Web/Mobile プロジェクトのみ）
   ↓
[Claude]   「1 件完了。次の依頼は?」（lean サイクルだった場合はテスト未実行も明示）
   ↓
[あなた]   「次は検索機能作って」 → 同じサイクルを繰り返す
   ↓ ...
[あなた]   「終了」
   ↓
[develop モード終了] セッション通算の報告（処理件数・変更ファイル数・追加テスト数・仕様書サマリ）
```

**1 件の処理サイクル:**

| Step | 部署 | 内容 | スキップ条件 |
| --- | --- | --- | --- |
| 0 | (Claude) | feature-name 決定 + 仕様書の有無確認 | なし |
| 1 | developer | 実装。仕様書ありなら沿って実装、無ければ依頼から実装。**UI を含む場合は Frontend Skills を先に呼び出す** | なし |
| 2 | reviewer | レビュー (Approve まで反復) | なし |
| 3 | tester | テスト作成 + **全体テスト実行**。失敗あれば修正可否をユーザー確認 | **`$CYCLE_MODE = "lean"` の場合はスキップ** |
| 4 | architect | 仕様書を新規作成 / 更新 | **仕様書あり** かつ **仕様書外の追加なし** の場合はスキップ |
| 5 | (Claude) | **モック起動の確認**。Web なら dev server、Mobile ならシミュレータ。ユーザー承認のもとで起動 | CLI / ライブラリなど起動対象が無いプロジェクトはスキップ |
| 6 | (Claude) | 完了報告（サイクル範囲 / 仕様書状態 / 変更ファイル / テスト状況 / 手動タスク / 起動状態） | なし |

**特徴:**

- 終了するには「終了」「exit」「終わり」「もう大丈夫」などと伝える
- 他のスラッシュコマンド（例: `/cc-development-team:architect`）を実行すると自動的にモードが切れる
- 仕様書がすでにある場合は `developer` がそれに沿って実装します
- 実装が仕様書を超えた場合（仕様書外の追加機能・要件があった場合）のみ `architect` が仕様書を更新します
- **サイクル範囲はモード開始時にヒアリングして選択します** (推奨は `lean`):
  - **`lean` (実装重視・推奨)**: tester はスキップ。1 サイクルが軽くテンポよく回せる。テストは実装が一通り終わってから `/cc-development-team:test` でまとめて実行
  - **`full` (フルサイクル)**: tester も毎サイクル呼んで、テストまで一気に回す。1 サイクルが重くなり時間がかかる
  - 途中で「フルに切り替えて」「軽量で」と言えば変更できます
- 実装が終わったら **「起動して動作確認しますか?」と聞いてくれます**。yes なら Web は dev server をローカルで、Mobile はシミュレータで起動します（必ずユーザー承認のもと）
- **UI / フロントエンドを実装するときは Frontend Skills を呼び出します**（Web → `frontend-patterns`、iOS → `swiftui-patterns` + `liquid-glass-design`、Android/KMP → `compose-multiplatform-patterns`）。`everything-claude-code` プラグインが入っていれば自動で動きます

**注意:** モードは Claude の会話文脈で保持されるため、長時間会話で context が圧縮されると失われる場合があります。その時は再度 `/cc-development-team:develop` で再開してください。

## テストフロー — `/cc-development-team:test`

`/cc-development-team:test` は develop とは独立した **テスト専用コマンド** です。

```
[あなた] /cc-development-team:test を実行（引数なしでも OK）
   ↓
[Claude] テスト対象を確認（特定機能 / プロジェクト全体）
   ↓ (特定機能の場合は仕様書リストから選択)
[tester] 受け入れ基準からテスト設計・追加
   ↓
[Claude] プロジェクト全体のテストランナーを実行
   ↓
[Claude] 結果報告（合格 / 失敗 / 改善候補）
   ↓
[Claude] 「発見された問題を修正しますか?」とユーザーに質問
   ↓
[あなた] yes → developer に修正依頼してグリーンまで反復 / no → 報告のみで終了
```

**ポイント:** ユーザー承認なしに修正は適用しません。失敗テストの修正も、改善候補の反映も、必ず確認してから進めます。
