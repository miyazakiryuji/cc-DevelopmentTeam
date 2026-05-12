---
description: cc-DevelopmentTeam プラグインの更新状況を GitHub と照合し、必要なら更新手順を案内する
---

このコマンドは 2 段階で動きます:

1. **GitHub と照合してチェック** (Bash で `git ls-remote --tags` を使う、認証不要)
2. **最新かどうかに応じて出し分け** ─ 最新なら「最新です」、古ければ更新手順を案内

プラグインがランタイム組み込みコマンド `/plugin uninstall` 等を直接呼び出すことはできないため、**更新の実行はユーザーが手動でコピペ** する設計です。

> **バージョン比較は タグ (Semantic Versioning) ベース** で行います。`v1.0.0` 以降は GitHub Releases にタグが切られている前提。タグが存在しない場合 (0.x 系初期) は HEAD コミット SHA でフォールバック比較します。

---

## Step 1: 最新リモートタグを取得

`Bash` で以下を実行（タイムアウト 5 秒、認証不要、ネット必須）:

```bash
git ls-remote --tags --sort=-v:refname https://github.com/miyazakiryuji/cc-DevelopmentTeam 2>/dev/null \
  | awk '{print $2}' | sed 's|refs/tags/||; s|\^{}$||' | grep -E '^v[0-9]' | head -1
```

結果を `$REMOTE_TAG` に保持。

**タグが見つからない場合** (まだ v タグが切られていない初期段階):
- HEAD コミット SHA にフォールバック:
  ```bash
  git ls-remote https://github.com/miyazakiryuji/cc-DevelopmentTeam HEAD 2>/dev/null | awk '{print $1}'
  ```
- 結果を `$REMOTE_SHA` に保持 (`$REMOTE_TAG = ""` のまま)。

**完全に失敗時** (ネット無し / GitHub 到達不可など):
- 「リモートのチェックに失敗しました。手動で <https://github.com/miyazakiryuji/cc-DevelopmentTeam/releases> を確認してください」と伝える
- そのまま Step 3 の「更新手順」を表示して終了 (チェックなしの旧挙動と同じ)

## Step 2: ローカルプラグインのバージョン / コミットを取得

以下の優先順で取得を試みる（**失敗してもエラーにせず**、取れた段階で打ち切る）:

```bash
# 候補 A: plugin.json の version フィールド
if [ -f "${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json" ]; then
  grep -E '"version"' "${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json" \
    | head -1 | sed 's/.*"version".*"\([^"]*\)".*/v\1/'
fi
```

結果を `$LOCAL_VERSION` に保持（例: `v0.1.0`）。

```bash
# 候補 B: $CLAUDE_PLUGIN_ROOT が .git を持つ場合 (フォールバック用)
if [ -d "${CLAUDE_PLUGIN_ROOT}/.git" ]; then
  git -C "${CLAUDE_PLUGIN_ROOT}" rev-parse HEAD 2>/dev/null
fi
```

結果を `$LOCAL_SHA` に保持。

`$LOCAL_VERSION` も `$LOCAL_SHA` も取れない場合は `$LOCAL_VERSION = unknown` 扱い。

## Step 3: 比較ロジック

| `$REMOTE_TAG` | `$LOCAL_VERSION` | 判定 |
| --- | --- | --- |
| あり | `$LOCAL_VERSION == $REMOTE_TAG` | **最新** (ケース A) |
| あり | `$LOCAL_VERSION != $REMOTE_TAG` (両方ある) | **更新あり** (ケース B、タグベース) |
| あり | `$LOCAL_VERSION == unknown` | **ケース C** (ローカル不明) |
| 空 (タグ未発行) | — | SHA フォールバック (`$LOCAL_SHA` vs `$REMOTE_SHA` で比較) |

## Step 4: 結果出力

### ケース A: 最新

```
【cc-DevelopmentTeam は最新版です ✓】

ローカルバージョン: $LOCAL_VERSION
GitHub 最新版    : $REMOTE_TAG
チェック日時      : <今日の日付>

特に更新は不要です!安心して開発を続けてください〜
```

### ケース B: 更新あり

リリースノートも取りに行く（オプション、失敗しても続行）:

```bash
# 最新リリースのタグ名と本文を取得 (gh CLI があれば)
gh release view --repo miyazakiryuji/cc-DevelopmentTeam --json tagName,publishedAt,body 2>/dev/null
# gh が無い場合は省略
```

出力例:

```
【cc-DevelopmentTeam に更新があります!】

ローカルバージョン: $LOCAL_VERSION
GitHub 最新版    : $REMOTE_TAG (<リリース日>)

[更新内容の主な変更]
<リリースノートから抜粋。取れなければ「変更内容は https://github.com/.../releases で確認」と案内>

[更新手順]
以下 3 つのコマンドを順番にコピペして実行してくださいね!

  /plugin uninstall cc-development-team

  /plugin marketplace update cc-development-team

  /plugin install cc-development-team@cc-development-team

実行後、念のため Claude Code を再起動すると確実です!(Ctrl+D で抜けて `claude` で再起動)

[反映確認]
/cc-development-team:architect を引数なしで実行し、「A: アプリ構想モード / B: 機能設計モード」のモード選択が出れば最新版です!

[詳しい変更履歴]
https://github.com/miyazakiryuji/cc-DevelopmentTeam/releases
https://github.com/miyazakiryuji/cc-DevelopmentTeam/blob/main/CHANGELOG.md
```

### ケース C: ローカルバージョン不明

```
【GitHub 最新版を確認しました】

GitHub 最新版    : $REMOTE_TAG
ローカルバージョン: 不明 (plugin.json の読み取り不可)

念のため更新手順を案内します。最新版のはずでも、改めて入れ直すと確実です:

  /plugin uninstall cc-development-team

  /plugin marketplace update cc-development-team

  /plugin install cc-development-team@cc-development-team

実行後、念のため Claude Code を再起動すると確実です!(Ctrl+D で抜けて `claude` で再起動)
```

### フォールバック: タグ未発行時 (`$REMOTE_TAG` が空)

SHA で比較し、ケース A / B / C と同様の出し分けをする (旧挙動)。出力には「リモートにまだタグが切られていません。コミット単位で比較します」と一言添える。

---

## 補足

- このコマンドは **チェックと案内のみ**。`/plugin uninstall` などの実行は行わない (ユーザー自身がコピペで実行)
- ネット接続が無い場合は警告した上で旧来の手順表示にフォールバック
- 反映されない場合は Claude Code の再起動を試す
- それでも古い挙動なら GitHub Releases で最新を確認: <https://github.com/miyazakiryuji/cc-DevelopmentTeam/releases>
- 変更履歴は CHANGELOG.md (リポジトリ直下) でも確認可能
