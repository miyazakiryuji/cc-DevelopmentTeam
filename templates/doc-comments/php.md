# 関数ドキュメントコメント — PHP (PHPDoc)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```php
/**
 * 注文 ID から請求書 PDF を生成して S3 に保存する。
 *
 * @param string $orderId 注文の一意 ID (UUID v4)
 * @param string $locale  PDF の言語 ("ja" または "en")
 * @return string 保存された S3 オブジェクトキー
 * @throws OrderNotFoundException 注文が見つからない場合
 * @throws StorageException S3 への書き込みに失敗した場合
 * @see docs/specs/invoice-export.md
 */
public function generateInvoice(string $orderId, string $locale = "ja"): string { ... }
```

