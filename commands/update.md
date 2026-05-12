---
description: cc-DevelopmentTeam プラグインの更新状況を GitHub と照合し、必要なら更新手順を案内する
---

このコマンドは 2 段階で動きます:

1. **GitHub と照合してチェック** (Bash で `git ls-remote` を使う、認証不要)
2. **最新かどうかに応じて出し分け** ─ 最新なら「最新です」、古ければ更新手順を案内

プラグインがランタイム組み込みコマンド `/plugin uninstall` 等を直接呼び出すことはできないため、**更新の実行はユーザーが手動でコピペ** する設計です。

---

## Step 1: 最新リモートコミットを取得

`Bash` で以下を実行（タイムアウト 5 秒、認証不要、ネット必須）:

```bash
git ls-remote https://github.com/miyazakiryuji/cc-DevelopmentTeam HEAD 2>/dev/null | awk '{print $1}'
```

結果を `$REMOTE_SHA` に保持。

**失敗時** (ネット無し / GitHub 到達不可など):
- 「リモートのチェックに失敗しました。手動で <https://github.com/miyazakiryuji/cc-DevelopmentTeam/commits/main> を確認してください」と伝える
- そのまま Step 3 の「更新手順」を表示して終了 (チェックなしの旧挙動と同じ)

## Step 2: ローカルプラグインのコミットを取得

`Bash` で以下を順に試す。**失敗してもエラーにせず**、取れた段階で打ち切る:

```bash
# 候補 A: $CLAUDE_PLUGIN_ROOT が .git を持つ場合
if [ -d "${CLAUDE_PLUGIN_ROOT}/.git" ]; then
  git -C "${CLAUDE_PLUGIN_ROOT}" rev-parse HEAD 2>/dev/null
fi
```

結果を `$LOCAL_SHA` に保持。`CLAUDE_PLUGIN_ROOT` が未解決 or `.git` が無い場合は `$LOCAL_SHA = unknown`。

## Step 3: 結果出力

### ケース A: `$LOCAL_SHA == $REMOTE_SHA` (最新)

```
【cc-DevelopmentTeam は最新版です ✓】

ローカルバージョン: <$LOCAL_SHA (短縮 7 文字)>
GitHub 最新版    : <$REMOTE_SHA (短縮 7 文字)>
チェック日時      : <今日の日付>

特に更新は不要です!安心して開発を続けてください〜
```

### ケース B: `$LOCAL_SHA != $REMOTE_SHA` (更新あり)

直近のコミット差分を取得して、何が更新されているかを軽く見せる:

```bash
# 直近 10 件のリモートコミットメッセージを取得 (オプション、失敗しても続行)
git ls-remote --tags https://github.com/miyazakiryuji/cc-DevelopmentTeam 2>/dev/null | tail -5
```

出力例:

```
【cc-DevelopmentTeam に更新があります!】

ローカルバージョン: <$LOCAL_SHA (短縮 7 文字)>
GitHub 最新版    : <$REMOTE_SHA (短縮 7 文字)>

[更新手順]
以下 3 つのコマンドを順番にコピペして実行してくださいね!

  /plugin uninstall cc-development-team

  /plugin marketplace update cc-development-team

  /plugin install cc-development-team@cc-development-team

実行後、念のため Claude Code を再起動すると確実です!(Ctrl+D で抜けて `claude` で再起動)

[反映確認]
/cc-development-team:architect を引数なしで実行し、「A: アプリ構想モード / B: 機能設計モード」のモード選択が出れば最新版です!

[変更履歴を見たい場合]
https://github.com/miyazakiryuji/cc-DevelopmentTeam/commits/main
```

### ケース C: `$LOCAL_SHA == unknown` (ローカル SHA 不明)

ローカルが git clone ではなくスナップショット配置の場合など:

```
【GitHub 最新版を確認しました】

GitHub 最新版    : <$REMOTE_SHA (短縮 7 文字)>
ローカルバージョン: 不明 (プラグインがスナップショット配置のためチェック不可)

念のため更新手順を案内します。最新版のはずでも、改めて入れ直すと確実です:

  /plugin uninstall cc-development-team

  /plugin marketplace update cc-development-team

  /plugin install cc-development-team@cc-development-team

実行後、念のため Claude Code を再起動すると確実です!(Ctrl+D で抜けて `claude` で再起動)
```

---

## 補足

- このコマンドは **チェックと案内のみ**。`/plugin uninstall` などの実行は行わない (ユーザー自身がコピペで実行)
- ネット接続が無い場合は警告した上で旧来の手順表示にフォールバック
- 反映されない場合は Claude Code の再起動を試す
- それでも古い挙動なら GitHub リポジトリで最新コミットを確認: <https://github.com/miyazakiryuji/cc-DevelopmentTeam>
