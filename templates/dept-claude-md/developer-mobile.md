# developer 部署 — プロジェクト固有メモ (Mobile)

このファイルは developer サブエージェントが起動時に読み込みます。
Mobile 開発のコーディング規約・実装パターンをここに書いてください。

## 技術スタック
- 言語: <Swift / Kotlin / Dart>
- UI フレームワーク: <SwiftUI / UIKit / Jetpack Compose / Flutter>
- DI: <Hilt / Koin / Swinject など>
- 非同期: <async/await / Coroutines / RxSwift・RxJava>
- 永続化: <Core Data / SwiftData / Room / Realm>
- ネットワーク: <URLSession / Retrofit / Ktor Client / Alamofire>

## コーディング規約
- フォーマッタ: <swift-format / ktlint>
- リンタ: <SwiftLint / detekt>
- 命名規約: 言語標準に従う

## 実装パターン
- View 層のスタイル（SwiftUI / Compose の慣習）
- ViewModel 層の責務範囲
- 状態管理（UIState / @Published / StateFlow）
- 依存性注入のパターン
- エラーハンドリング（Result 型 / sealed class）

## ビルド・実行コマンド
- iOS ビルド: `xcodebuild -scheme <name> build`
- iOS シミュレータ実行: Xcode から、または `xcrun simctl`
- Android ビルド: `./gradlew assembleDebug`
- Android 実行: `./gradlew installDebug`
- 静的解析: `<コマンド>`

## 端末・OS 対応
- 最小サポートバージョン
- iPad / タブレット対応の必要性
- ランドスケープ対応
- ダークモード対応
