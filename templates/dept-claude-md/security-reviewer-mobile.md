# security-reviewer 部署 — プロジェクト固有メモ (Mobile)

このファイルは security-reviewer サブエージェントが起動時に読み込みます。
Mobile 開発でのセキュリティ点検観点をここに書いてください。

## 取り扱う個人情報・機密データ
- 個人情報の種類: <氏名 / メール / 住所 / 電話 / 位置情報 / 決済情報 / その他>
- 機密データ: <API キー / 認証トークン / バイオメトリクス 等>

## 規制・コンプライアンス
- 適用される規制: <個人情報保護法 / GDPR / その他>
- ストア審査要件 (App Store / Google Play) の特記事項

## 脅威モデル
- 想定される攻撃: <ジェイルブレイク / ルート化端末からの抽出 / 中間者攻撃 等>
- 守りたい資産: <ローカル DB / Keychain / Keystore に保管している情報>

## 端末ストレージ
- iOS Keychain の使用範囲・accessibility 設定
- Android Keystore の使用範囲
- 平文保存禁止項目

## ネットワーク
- 証明書ピンニング: 有 / 無
- ATS (iOS) / Network Security Config (Android) の設定方針
- 例外ドメイン (許可している http や TLS 弱化)

## App 権限
- 要求する権限: <カメラ / 位置情報 / 連絡先 等> とその justification
- 動的権限取得のタイミング

## ディープリンク / Intent
- 受け付ける scheme / Universal Links / App Links
- パラメータ検証ポリシー
- Android implicit intent / exported activity の方針

## 既知の脆弱性 / 対応履歴
- <YYYY-MM-DD: 何があってどう対応したかのログ>
