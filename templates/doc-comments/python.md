# 関数ドキュメントコメント — Python (Google スタイル docstring)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```python
def generate_invoice(order_id: str, locale: str = "ja") -> str:
    """注文 ID から請求書 PDF を生成して S3 に保存する。

    Args:
        order_id: 注文の一意 ID (UUID v4)。
        locale: PDF の言語。"ja" または "en" を指定。

    Returns:
        保存された S3 オブジェクトキー。

    Raises:
        OrderNotFoundError: 注文が見つからない場合。
        StorageError: S3 への書き込みに失敗した場合。

    See Also:
        docs/specs/invoice-export.md
    """
```

