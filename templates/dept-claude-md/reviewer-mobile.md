# reviewer 部署 — プロジェクト固有メモ (Mobile)

このファイルは reviewer サブエージェントが起動時に読み込みます。
Mobile 開発でのレビュー観点をここに書いてください。

## このプロジェクトで必ず見る観点

### セキュリティ
- 秘密情報の埋め込み（API キー・証明書のハードコード禁止）
- Keychain / Keystore の正しい使い方
- 証明書ピンニング
- ATS (iOS) / Network Security Config (Android)

### メモリ・性能
- リテイン サイクル / 循環参照
- メインスレッドでの重い処理
- リーク
- 過剰な再コンポジション (Compose) / 再描画 (SwiftUI)

### ライフサイクル
- View / ViewModel のライフサイクル整合性
- バックグラウンド遷移時の状態保存
- プロセスキル後の復元

### アクセシビリティ
- VoiceOver / TalkBack ラベル
- Dynamic Type 対応
- コントラスト比

### ストア審査
- 必要な権限（camera / location / contacts）の justification
- プライバシーマニフェスト (iOS)
- ターゲット SDK バージョン要件 (Android)

## severity 判定の調整
- Critical: 秘密情報埋め込み、無認可のデータアクセス、クラッシュバグ、ストア審査拒否要因
- High: メモリリーク、メインスレッドブロック、a11y 違反
- Medium: 命名・構造・パフォーマンス改善余地
- Low: スタイル・好み

## レビューで使う追加チェックリスト
- バックグラウンド時の挙動
- 通知タップからの起動経路
- 異なる画面サイズ・回転での見え方
