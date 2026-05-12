# 関数ドキュメントコメント — Dart (dartdoc) — Flutter

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```dart
/// 注文 ID から請求書 PDF を生成して S3 に保存する。
///
/// [orderId] は UUID v4 形式の文字列を期待する。
/// [locale] は `'ja'` または `'en'`。デフォルトは `'ja'`。
///
/// 戻り値は保存された S3 オブジェクトキー。
///
/// Throws [OrderNotFoundException] / [StorageException]。
Future<String> generateInvoice(String orderId, {String locale = 'ja'}) async { ... }
```

