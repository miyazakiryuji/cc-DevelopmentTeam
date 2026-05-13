#!/usr/bin/env bash
#
# exit-guard.sh — UserPromptSubmit hook
#
# ユーザーが develop / brainstorm モードを抜けるつもりで `exit` / `quit` と
# 入力したとき、Claude Code 自体が落ちないように介入する。
#
# 入力: stdin から prompt と context が JSON で渡される
# 出力: stdout に JSON。block: true で阻止、reason をユーザーに表示
#
# Claude Code の hook 仕様に基づく実装。
# 参考: https://docs.claude.com/en/docs/claude-code/hooks
#

set -euo pipefail

# stdin から JSON を読み込み、prompt を抽出
INPUT=$(cat)
PROMPT=$(printf '%s' "$INPUT" | sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

# prompt を trim
TRIMMED=$(printf '%s' "$PROMPT" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# `exit` / `quit` 単独 (大文字小文字区別なし) を検出
LOWER=$(printf '%s' "$TRIMMED" | tr '[:upper:]' '[:lower:]')

case "$LOWER" in
  exit|quit|"exit()"|"quit()")
    # ブロックして案内
    cat <<'EOF'
{
  "decision": "block",
  "reason": "⚠️ `exit` / `quit` は Claude Code 自体を終了させる可能性があります。\n\n何を終了したいか教えてください:\n- develop モードを抜けたい → 「終了」「終わり」「もう大丈夫」と入力\n- Claude Code 自体を抜けたい → そのまま意図的に exit を入力 (このメッセージを無視して再送信)"
}
EOF
    exit 0
    ;;
  *)
    # 通常通過
    echo '{"decision": "allow"}'
    exit 0
    ;;
esac
