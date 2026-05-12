# 関数ドキュメントコメント — Go (godoc 形式)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```go
// GenerateInvoice は注文 ID から請求書 PDF を生成して S3 に保存する。
//
// orderId は UUID v4 形式の文字列を期待する。locale には "ja" または "en" を指定。
// 戻り値は保存された S3 オブジェクトキー。
//
// エラー:
//   - ErrOrderNotFound: 注文が見つからない場合
//   - ErrStorageWrite:  S3 への書き込みに失敗した場合
//
// 関連: docs/specs/invoice-export.md
func GenerateInvoice(orderId string, locale string) (string, error) { ... }
```

