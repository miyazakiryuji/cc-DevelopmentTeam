# 関数ドキュメントコメント — C# (XML doc comments)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)

```csharp
/// <summary>
/// 注文 ID から請求書 PDF を生成して S3 に保存する。
/// </summary>
/// <param name="orderId">注文の一意 ID (UUID v4)</param>
/// <param name="locale">PDF の言語 ("ja" または "en")。デフォルトは "ja"</param>
/// <returns>保存された S3 オブジェクトキー</returns>
/// <exception cref="OrderNotFoundException">注文が見つからない場合</exception>
/// <exception cref="StorageException">S3 への書き込みに失敗した場合</exception>
/// <seealso href="docs/specs/invoice-export.md"/>
public async Task<string> GenerateInvoiceAsync(string orderId, string locale = "ja") { ... }
```
