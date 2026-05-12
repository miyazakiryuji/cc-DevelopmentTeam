# 関数ドキュメントコメント — Rust (rustdoc)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```rust
/// 注文 ID から請求書 PDF を生成して S3 に保存する。
///
/// # Arguments
/// * `order_id` - 注文の一意 ID (UUID v4)
/// * `locale` - PDF の言語 ("ja" | "en")
///
/// # Errors
/// * [`OrderError::NotFound`] - 注文が見つからない場合
/// * [`StorageError::WriteFailed`] - S3 書き込み失敗
///
/// # Example
/// ```
/// let key = generate_invoice("abc-123", "en").await?;
/// ```
pub async fn generate_invoice(order_id: &str, locale: &str) -> Result<String, Error> { ... }
```

