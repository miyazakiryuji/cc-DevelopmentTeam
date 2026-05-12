# 関数ドキュメントコメント — SQL (関数 / ストアドプロシージャのヘッダコメント)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```sql
-- generate_invoice — 注文 ID から請求書レコードを生成する。
--
-- Parameters:
--   p_order_id  TEXT     注文の一意 ID (UUID v4)
--   p_locale    TEXT     PDF の言語 ("ja" or "en"), default "ja"
--
-- Returns:
--   TEXT — 保存された S3 オブジェクトキー
--
-- Exceptions:
--   ORDER_NOT_FOUND      注文が見つからない場合
--   STORAGE_WRITE_FAILED 書き込みに失敗した場合
--
-- See: docs/specs/invoice-export.md
CREATE OR REPLACE FUNCTION generate_invoice(p_order_id TEXT, p_locale TEXT DEFAULT 'ja')
RETURNS TEXT AS $$ ... $$ LANGUAGE plpgsql;
```

