# 関数ドキュメントコメント — Bash / Shell (ヘッダコメント慣習)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```bash
# generate_invoice — 注文 ID から請求書 PDF を生成して S3 に保存する。
#
# Arguments:
#   $1 — order_id  : 注文の一意 ID (UUID v4)
#   $2 — locale    : PDF の言語 ("ja" or "en")。省略時は "ja"
#
# Outputs:
#   stdout  : 保存された S3 オブジェクトキー
#
# Returns:
#   0  : 成功
#   1  : 注文が見つからない (ORDER_NOT_FOUND)
#   2  : S3 書き込み失敗 (STORAGE_WRITE_FAILED)
#
# See: docs/specs/invoice-export.md
generate_invoice() {
  local order_id="$1"
  local locale="${2:-ja}"
  ...
}
```

