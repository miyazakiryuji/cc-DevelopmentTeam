# 関数ドキュメントコメント — Lua (LDoc)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```lua
--- 注文 ID から請求書 PDF を生成して S3 に保存する。
-- @param order_id (string) 注文の一意 ID (UUID v4)
-- @param locale   (string) PDF の言語 ("ja" or "en"), default "ja"
-- @return (string) 保存された S3 オブジェクトキー
-- @raise "ORDER_NOT_FOUND" / "STORAGE_WRITE_FAILED"
-- @see docs/specs/invoice-export.md
local function generate_invoice(order_id, locale) ... end
```

