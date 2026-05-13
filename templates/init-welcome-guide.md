<!--
このファイルは init-dept コマンドの最後にユーザーへ表示するウェルカム説明です。
init-dept から Read してそのままユーザーに表示します。
-->

【cc-DevelopmentTeam へようこそ!!】

このプラグインは、Claude Code を使った開発を「会社の4部署」みたいに分担させるツールです!
ひとりで開発していても、心の中に 4 人の同僚を持つことができます (孤独感は若干緩和されます!)。

## このプラグインで何ができるの?

以下の 4 部署を順番に呼び出して開発を進めます:

| 部署 | 担当 | 何をしてくれる人? |
| --- | --- | --- |
| architect | 設計部署 | 「何を作るか」を仕様書にまとめてくれる |
| developer | 開発部署 | 仕様書(または依頼)に沿ってコードを書いてくれる |
| reviewer | レビュー部署 | 「ここちょっと危ないですよ」と指摘してくれる(コードは書き換えない) |
| tester | テスト部署 | テストを書いて、実行して、緑になるまで面倒を見てくれる |

加えて専門アドバイザーが 1 人います:

| 部署 | 担当 | 何をしてくれる人? |
| --- | --- | --- |
| security-reviewer | セキュリティ専門アドバイザー | OWASP 観点 / 秘密情報漏れ / 認可漏れ / 依存脆弱性 など、セキュリティに集中して点検。普段は黙っているが、認証・決済・個人情報を扱った後や、リリース前点検で呼ぶと頼れる |

各部署は基本ボランティアで働きます。給料は要りません。但し、たまに人間と同じく勘違いします。

## 主な使い方(段階的に進めていけます)

| 自分の状況 | コマンド | 何が起きる? |
| --- | --- | --- |
| **何から始めればいいか分からない** | **/cc-development-team:guide** | **迷ったらまずこれ**。状況を聞いて次のコマンドを案内 |
| そもそも何を作るか決まってない | /cc-development-team:brainstorm | 雑談ベースでアイデアを 3〜5 個出してくれる |
| アプリ案は決まった、仕様書を作りたい | /cc-development-team:architect | architect が呼ばれて仕様書を作って終了(設計だけ) |
| 設計まで終わった、コードを書きたい | /cc-development-team:develop | develop モードに入る。終了するまで連続で開発を回せる |
| コードを書いた、テストもしたい | /cc-development-team:test | tester が呼ばれてテスト追加 + 実行。失敗修正はユーザー確認後 |

「何を作ろうかな」状態なら brainstorm → architect → develop → test の順に進むと安心です。
途中から入っても OK (例: 既に作るものが決まってるなら brainstorm はスキップして architect から)。
**迷ったら /cc-development-team:guide を実行してください。今の状況に応じて次の一手を教えてくれます。**

## その他のコマンド

| コマンド | 用途 |
| --- | --- |
| /cc-development-team:status | プロジェクトの現状ダッシュボード(進捗・残タスク・次のオススメを表示) |
| /cc-development-team:refactor | リファクタリング専用(既存テスト Before/After を厳守) |
| /cc-development-team:release-check | リリース前の総合チェック + リリースノート自動生成 |
| /cc-development-team:security-review | セキュリティ専門点検(認証/決済/個人情報を扱った後や、リリース前に) |
| /cc-development-team:sync-spec | 仕様書とコードのズレを健康診断 |
| /cc-development-team:update | プラグイン本体を最新版に更新する手順を表示 |
| /cc-development-team:init-dept | この初期化コマンド(再実行も可能) |

## アプリ作りの典型的な進め方

```
[1] 「何作ろうかな…」  →  /cc-development-team:brainstorm    (アイデアを出す)
       ↓ 案が決まった
[2] 「何を作るか整理」  →  /cc-development-team:architect        (仕様書を作る)
       ↓ 仕様書ができた
[3] 「コード書きたい」  →  /cc-development-team:develop       (実装する)
       ↓ 実装が落ち着いた
[4] 「テスト書きたい」  →  /cc-development-team:test         (テスト追加・実行)
```

各ステップは独立して使えるので、既に案がある人は [2] から、設計が手元にある人は [3] からどうぞ。

## ちょっとした補足

- 仕様書は docs/specs/<feature-name>.md に貯まります。後から「何を作ったか」を見返せるので、
  未来の自分が泣いて喜びます。
- 各部署のプロジェクト固有メモは docs/dept/architect/CLAUDE.md と dept/{developer,reviewer,tester,security-reviewer}/CLAUDE.md
  に置かれます。初期テンプレが入っているだけなので、慣れてきたら埋めるとサブエージェントの精度が上がります(空でも動きます)。
- 開発中に「Firebase の設定」「OAuth クライアント登録」など **人間が UI で操作しないと進まないタスク** が出てきたら、
  docs/manual-tasks/<feature-name>.md に自動でまとめられます。仕様書からもリンクされ、関連コードには
  // TODO(manual): ... のコメントが残るので、何を手で設定すべきか後から追えます。
- develop モードから抜けたい時は「終了」「終わり」「もう大丈夫」のどれかを伝えてください。脱出口は常にあります。
- 詳しい使い方や FAQ は README をご覧ください。
- 部署別の CLAUDE.md は後から自由に編集できます。種別 (Web / Mobile) を変えたい場合は、各 CLAUDE.md
  を直接書き換えるか、削除してから /cc-development-team:init-dept を再実行してください。
