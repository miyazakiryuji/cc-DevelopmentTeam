---
description: 「このプラグインをどう使えばいいか分からない」人向けの対話型ガイド。今の状況をヒアリングして、次に打つコマンドを教える。
---

このコマンドは **「何から始めればいいか分からない」「次に何すればいいか分からない」** という状態のユーザー向けの **対話型ガイド** です。

雑談ベースで今の状況を聞き、次に打つべきコマンドを **1〜2 個に絞って** 案内します。情報過多にしません。

## 進め方の基本

- **雑談ベース、堅苦しくしない**
- 一気に全部説明しない（情報過多禁止）
- 「今すぐ打つコマンド」を 1〜2 個に絞って提示
- その先のロードマップは要約だけ示す
- 終わったら「また /cc-development-team:guide で相談できますよ」と伝える

---

## Step 1: ウェルカム + 状況ヒアリング

最初に必ず以下を表示してください:

```
【ガイドモードへようこそ!】

このプラグインで何をどう使えばいいか、一緒に整理していきましょう!
肩の力を抜いてくださいね。今の状況を教えてくれれば、次に打つコマンドを 1 つだけ案内します。

今の状況に近いものを選んでください (番号で OK!):

a) アプリ案がまだ思いついていない（何作ろうかなー段階）
b) アプリ案はある、これから設計を始めたい
c) 仕様書は出来てる、これからコードを書きたい
d) コードもある程度ある、整理 / 点検 / 公開準備に進みたい
e) 特定のことだけ相談したい（バグ・リファクタ・セキュリティ 等）
f) このプラグインの全体像をまず知りたい

(複数当てはまるなら、一番近いものでOKです!)
```

ユーザーの回答を待ち、選んだ番号に応じて Step 2 へ。

---

## Step 2: 分岐ごとの案内

### a) アプリ案がまだ思いついていない

以下を表示:

```
【オススメ: /cc-development-team:brainstorm】

雑談ベースで「最近気になってること」「困りごと」「興味分野」を聞いてくれます!
そこからアプリ案を 3〜5 個提案。気に入った案が見つかったら、そのまま
設計フェーズへの橋渡しまでしてくれます。プレッシャーゼロなので安心してくださいね!

▶ 今すぐ打つコマンド:
  /cc-development-team:brainstorm

▶ このあとの流れ:
  brainstorm → design → develop → (release-check)

楽しい開発の第一歩です!行ってみましょう!
```

### b) アプリ案はある、これから設計

以下を表示:

```
【オススメ: /cc-development-team:design】

設計部署 (architect) が仕様書を作ってくれます! 引数なしで起動すると、
以下のいずれかを選べます:

- アプリ全体の構想から進めたい (vision.md + roadmap.md 生成)
- 新規の機能 1 個だけ設計したい
- 既存の仕様書を更新したい (仕様書リストから選択可)

仕様書ファイル名を覚えてなくても、リストから選べるので大丈夫です!

▶ 今すぐ打つコマンド:
  /cc-development-team:design

▶ このあとの流れ:
  design → develop → (security-review) → release-check

しっかり整理してから作ると後が楽になりますよ〜!
```

### c) 仕様書はある、コードを書きたい

以下を表示:

```
【オススメ: /cc-development-team:develop】

develop モードに入ります! 終了するまで、依頼を受けるたびに
「developer → reviewer → tester → architect (必要時のみ)」のサイクルを
回してくれます。動作確認 (dev server 起動 or シミュレータ起動) まで
やってくれます!

仕様書が既にある場合は、それに沿って実装してくれます。
仕様書外の追加機能があれば、最後に仕様書も自動更新されますよ〜。

▶ 今すぐ打つコマンド:
  /cc-development-team:develop

▶ このあとの流れ:
  develop → (security-review) → status → release-check

▶ develop モードを抜けたい時は「終了」「exit」「終わり」などと伝えてくださいね!
```

### d) コードがある程度ある、整理・点検・公開へ

以下を表示:

```
【オススメ: まずは /cc-development-team:status で全体俯瞰】

プロジェクトの現状ダッシュボードが表示されます (進捗・残タスク・
次のオススメ アクション)。それを見て次の一手を決めましょう。

▶ 今すぐ打つコマンド:
  /cc-development-team:status

▶ status の結果に応じて次のアクション:
- 手動タスクが残ってる → 該当タスクを解消
- 認証/決済/個人情報を扱う機能あり → /cc-development-team:security-review
- 仕様書とコードがズレてないか確認 → /cc-development-team:sync-spec
- リリース直前 → /cc-development-team:release-check
- リファクタしたい箇所がある → /cc-development-team:refactor
```

### e) 特定のことだけ相談したい

以下を表示:

```
何を相談したいか教えてください。よくあるパターンを並べておきます:

| 困りごと / やりたいこと | 使うコマンド |
| --- | --- |
| バグ修正 / 既存機能の修正 | /cc-development-team:develop で依頼 |
| 既存コードのリファクタ | /cc-development-team:refactor |
| Firebase / Supabase 等の手動設定漏れがないか | docs/manual-tasks/ を確認 or /status |
| セキュリティが心配 | /cc-development-team:security-review |
| 仕様書とコードのズレ確認 | /cc-development-team:sync-spec |
| 現状の全体把握 | /cc-development-team:status |
| リリース前チェック | /cc-development-team:release-check |
| プラグイン本体を更新したい | /cc-development-team:update |

具体的に教えてもらえれば、より適切なコマンドを案内します。
どんな話ですか?
```

ユーザーの回答を聞いて、上の表を参考に最適なコマンドを 1〜2 個に絞って案内する。

### f) プラグインの全体像を知りたい

以下を表示:

```
【cc-DevelopmentTeam の全体像】

このプラグインは「個人開発を 4 部署体制で進める」ツールです。

# 4 部署 + 専門アドバイザー
| 部署 | 役割 |
| --- | --- |
| architect    | 設計 (仕様書作成) |
| developer    | コード実装 |
| reviewer     | コード品質レビュー |
| tester       | テスト作成 + 実行 |
| security-reviewer | セキュリティ専門レビュー (専門アドバイザー) |

# 典型的なフロー
1. 何を作ろう? → /cc-development-team:brainstorm
2. 何を作るか整理 → /cc-development-team:design
3. コード書く → /cc-development-team:develop
4. 進捗確認 → /cc-development-team:status
5. セキュリティ点検 → /cc-development-team:security-review
6. リリース準備 → /cc-development-team:release-check

# その他のサポート
- /cc-development-team:refactor (リファクタ専用フロー)
- /cc-development-team:sync-spec (仕様書とコードの整合性チェック)
- /cc-development-team:init-dept (プロジェクト初期化、最初に 1 回)
- /cc-development-team:update (プラグイン本体の更新手順)

詳しい話は README をご覧ください。

このあと何しますか?
- ガイドを続けて自分の状況を相談する → 「a」「b」「c」「d」「e」のどれかを教えてください
- まずは自分で試してみる → 上のコマンドを打ってみてください
```

ユーザーが a〜e のどれかを選び直したら、その分岐へ。

---

## Step 3: 最後の案内（共通）

a〜f のどの分岐でも、最後に必ず以下を表示:

```
他に何か気になることがあれば、いつでも /cc-development-team:guide を再実行してくださいね!
それでは、楽しい開発を!応援してます!!
```

---

## やってはいけないこと

- **情報過多にする**（1 回の案内で 1〜2 個のコマンドに絞る）
- ユーザーが a〜f のどれを選んでないのに勝手に進める
- 「これも必要、あれも必要」と圧をかける（ペースはユーザー次第）
- コマンドの詳細仕様まで全部説明する（README に書いてある）
- このコマンド自体が長時間続くようにする（次のコマンドへ早めに送り出す）
