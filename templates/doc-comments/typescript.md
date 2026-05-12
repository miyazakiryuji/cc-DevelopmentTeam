# 関数ドキュメントコメント — TypeScript / JavaScript (TSDoc / JSDoc)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```typescript
/**
 * 注文 ID から請求書 PDF を生成して S3 に保存する。
 *
 * @param orderId - 注文の一意 ID (UUID v4)
 * @param options.locale - PDF の言語 (default: "ja")
 * @returns 保存された S3 オブジェクトキー
 * @throws {OrderNotFoundError} 注文が見つからない場合
 * @throws {StorageError} S3 への書き込みに失敗した場合
 *
 * @see docs/specs/invoice-export.md
 *
 * @example
 * const key = await generateInvoice("abc-123", { locale: "en" });
 */
export async function generateInvoice(
  orderId: string,
  options?: { locale?: "ja" | "en" },
): Promise<string> { ... }
```

