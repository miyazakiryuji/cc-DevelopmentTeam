---
description: cc-DevelopmentTeam プラグインとプロジェクトの初期化状態を診断する (読み取り専用)
---

このコマンドは **プラグイン環境とプロジェクト初期化の健康診断** を行います。読み取り専用で、何も書き換えません。トラブル時の最初の手がかりとしてどうぞ。

---

## Step 1: プラグイン側のチェック

### 1-1. `CLAUDE_PLUGIN_ROOT` の解決

```bash
echo "${CLAUDE_PLUGIN_ROOT:-未解決}"
```

- 値あり → ✓ `$CLAUDE_PLUGIN_ROOT = <パス>`
- 未解決 → ✗ 「環境変数が解決できません。Claude Code を再起動してみてください」

### 1-2. 主要ファイルの存在確認

以下を `Bash` で 1 行ずつ `[ -f <path> ] && echo "✓ <path>" || echo "✗ <path> 見つかりません"` で確認:

- `${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json`
- `${CLAUDE_PLUGIN_ROOT}/agents/architect.md`
- `${CLAUDE_PLUGIN_ROOT}/agents/developer.md`
- `${CLAUDE_PLUGIN_ROOT}/agents/reviewer.md`
- `${CLAUDE_PLUGIN_ROOT}/agents/tester.md`
- `${CLAUDE_PLUGIN_ROOT}/agents/security-reviewer.md`
- `${CLAUDE_PLUGIN_ROOT}/commands/architect.md`
- `${CLAUDE_PLUGIN_ROOT}/commands/develop.md`
- `${CLAUDE_PLUGIN_ROOT}/commands/init-dept.md`

### 1-3. 参照テンプレ群の存在確認

主ファイルから「必要時に Read する」設計になっている参照ファイル群:

```bash
# テンプレ系
for f in vision-template requirements-template basic-design-template spec-template manual-tasks-template init-welcome-guide; do
  [ -f "${CLAUDE_PLUGIN_ROOT}/templates/${f}.md" ] && echo "✓ templates/${f}.md" || echo "✗ templates/${f}.md"
done

# architect モード詳細
for f in mode-a-vision mode-b-feature; do
  [ -f "${CLAUDE_PLUGIN_ROOT}/templates/architect/${f}.md" ] && echo "✓ templates/architect/${f}.md" || echo "✗ templates/architect/${f}.md"
done

# 部署 CLAUDE.md (10 ファイル)
for dept in architect developer reviewer tester security-reviewer; do
  for variant in web mobile; do
    [ -f "${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/${dept}-${variant}.md" ] && echo "✓ templates/dept-claude-md/${dept}-${variant}.md" || echo "✗ templates/dept-claude-md/${dept}-${variant}.md"
  done
done

# develop 関連
[ -f "${CLAUDE_PLUGIN_ROOT}/templates/develop/mock-launch-commands.md" ] && echo "✓ templates/develop/mock-launch-commands.md" || echo "✗ templates/develop/mock-launch-commands.md"

# doc-comments (19 言語)
DOC_COMMENT_FOUND=$(ls "${CLAUDE_PLUGIN_ROOT}/templates/doc-comments/" 2>/dev/null | wc -l | tr -d ' ')
echo "doc-comments 言語数: ${DOC_COMMENT_FOUND} / 19 期待"
```

### 1-4. プラグインバージョン

```bash
grep -E '"version"' "${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json" | head -1 | sed 's/.*"version".*"\([^"]*\)".*/v\1/'
```

## Step 2: プロジェクト側 (init-dept 実行済みか)

カレントディレクトリ (ユーザーのプロジェクト) で以下を確認:

### 2-1. ルートファイル

```bash
[ -f "CLAUDE.md" ] && echo "✓ CLAUDE.md" || echo "✗ CLAUDE.md (init-dept 未実行?)"
```

CLAUDE.md があれば「プロジェクト種別」「設計思想」「アプリコード配置」を grep で抽出:

```bash
grep -E "^\*\*プロジェクト種別:|^\*\*設計思想:|^\*\*アプリコード配置:" CLAUDE.md | head -3
```

### 2-2. docs/ ディレクトリ

```bash
for d in docs/vision docs/basic-design docs/requirements docs/specs docs/manual-tasks; do
  [ -d "$d" ] && echo "✓ $d/" || echo "✗ $d/ (init-dept で作成されるはず)"
done
```

### 2-3. dept/ ディレクトリ

```bash
[ -f "docs/dept/architect/CLAUDE.md" ] && echo "✓ docs/dept/architect/CLAUDE.md" || echo "✗ docs/dept/architect/CLAUDE.md"
for dept in developer reviewer tester security-reviewer; do
  [ -f "dept/${dept}/CLAUDE.md" ] && echo "✓ dept/${dept}/CLAUDE.md" || echo "✗ dept/${dept}/CLAUDE.md"
done
```

### 2-4. design/ ディレクトリ (Mobile/Web 共通)

```bash
[ -d "design" ] && echo "✓ design/" || echo "✗ design/ (任意。あれば便利)"
```

## Step 3: 連携プラグインのチェック (オプション)

`/cc-development-team:develop` の UI 実装時に呼ばれる Frontend Skills は `everything-claude-code` プラグイン経由です。

```bash
# Claude Code の settings.json 等を確認
ls ~/.claude/plugins/ 2>/dev/null | grep -i "everything-claude-code" || echo "未検出"
```

検出 → ✓ Frontend Skills (frontend-patterns / swiftui-patterns / compose-multiplatform-patterns / liquid-glass-design) が利用可能
未検出 → ⚠ UI 実装時は一般的なベストプラクティスで進めます (Skill 連携は無効)

## Step 4: 結果出力

以下のフォーマットで結果をまとめて表示:

```
【cc-DevelopmentTeam 診断結果】

# プラグイン側
- $CLAUDE_PLUGIN_ROOT: ✓ <path>  (or ✗ 未解決)
- プラグインバージョン: v0.1.0
- 主要 agent / command ファイル: ✓ X/X 件揃っている
- テンプレ参照ファイル: ✓ X/X 件 (or ✗ N 件不足)
- doc-comments: 19 / 19 言語

# プロジェクト側 (init-dept 実行済みか)
- CLAUDE.md: ✓
  - プロジェクト種別: Web
  - 設計思想: Feature-based
  - アプリコード配置: src/
- docs/ 配下 (vision/basic-design/requirements/specs/manual-tasks): ✓ 5/5
- dept/ 配下 (developer/reviewer/tester/security-reviewer): ✓ 4/4
- docs/dept/architect/CLAUDE.md: ✓
- design/ ディレクトリ: ✓

# 連携プラグイン (任意)
- everything-claude-code (Frontend Skills 用): ✓ 検出

# 総合判定
☑ 健康です!安心して開発してください〜

(✗ がある場合)
☐ 以下を解決してください:
  1. <具体的なアクション>
  2. <具体的なアクション>
```

### 推奨アクションの出し分け

| 問題 | 推奨アクション |
| --- | --- |
| `$CLAUDE_PLUGIN_ROOT` 未解決 | Claude Code を再起動。それでもダメなら `/cc-development-team:update` で再インストール |
| 主要ファイルが欠ける | プラグインが破損。`/cc-development-team:update` で再インストール |
| `CLAUDE.md` が無い | `/cc-development-team:init-dept` を実行 |
| `docs/` / `dept/` が無い | 同上 |
| `everything-claude-code` 未検出 | `/plugin install everything-claude-code@<marketplace>` (任意。UI 実装の精度が上がる) |

---

## やってはいけないこと

- このコマンドで **何も書き換えない** (診断専用、読み取り専用)
- 自動で何かを修正する (推奨アクションの表示のみ。実行はユーザー自身)
- 機密情報 (`.env`, secret) を表示する (Step 2 では設定値の中身は読まず存在確認のみ)
