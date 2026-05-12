# 関数ドキュメントコメント — Ruby (YARD)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```ruby
# 注文 ID から請求書 PDF を生成して S3 に保存する。
#
# @param order_id [String] 注文の一意 ID (UUID v4)
# @param locale [String] PDF の言語 ("ja" または "en")
# @return [String] 保存された S3 オブジェクトキー
# @raise [OrderNotFoundError] 注文が見つからない場合
# @raise [StorageError] S3 への書き込みに失敗した場合
# @see docs/specs/invoice-export.md
# @example
#   key = generate_invoice("abc-123", locale: "en")
def generate_invoice(order_id, locale: "ja")
  ...
end
```

