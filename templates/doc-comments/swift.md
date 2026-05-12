# 関数ドキュメントコメント — Swift (Swift Markup)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```swift
/// 注文 ID から請求書 PDF を生成して S3 に保存する。
///
/// - Parameters:
///   - orderId: 注文の一意 ID (UUID v4)
///   - locale: PDF の言語。デフォルトは `.ja`
/// - Returns: 保存された S3 オブジェクトキー
/// - Throws: `OrderError.notFound` / `StorageError.writeFailed`
///
/// - SeeAlso: `docs/specs/invoice-export.md`
func generateInvoice(orderId: String, locale: Locale = .ja) async throws -> String {
    ...
}
```

