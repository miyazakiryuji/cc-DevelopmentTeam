# 関数ドキュメントコメント — Haskell (Haddock)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```haskell
-- | 注文 ID から請求書 PDF を生成して S3 に保存する。
--
-- /Throws:/ 'OrderNotFoundException', 'StorageException'
--
-- @See "docs/specs/invoice-export.md"@
generateInvoice
  :: Text        -- ^ 注文の一意 ID (UUID v4)
  -> Text        -- ^ PDF の言語 ("ja" or "en")
  -> IO Text     -- ^ 保存された S3 オブジェクトキー
generateInvoice orderId locale = ...
```

