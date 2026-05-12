# モバイルアプリ開発の IDE 推奨

モバイルアプリを開発する場合、**プロジェクト自体は専用 IDE から開く** ことを強く推奨します。Claude Code でもコードは書けますが、**ビルド・シミュレータ起動・実機デバッグ・UI プレビュー・証明書管理** などはネイティブ IDE が圧倒的に便利です。

## プラットフォーム別の推奨 IDE

| プラットフォーム | 推奨 IDE | 公式ダウンロード |
| --- | --- | --- |
| iOS / macOS (Swift / SwiftUI) | **Xcode** | <https://developer.apple.com/xcode/> |
| Android (Kotlin / Jetpack Compose) | **Android Studio** | <https://developer.android.com/studio> |
| Flutter (iOS + Android) | Android Studio または VS Code + Flutter 拡張 | <https://flutter.dev/> |
| React Native (iOS + Android) | VS Code + React Native 拡張 | <https://reactnative.dev/> |
| Kotlin Multiplatform (KMP) | Android Studio + KMP プラグイン | <https://kotlinlang.org/docs/multiplatform.html> |

## おすすめの使い分け

1. **プロジェクトを開く・実行する** → 専用 IDE で行う（ビルド・シミュレータ・実機デバッグ）
2. **コードを書く・仕様書を作る・テストを追加する** → Claude Code（このプラグイン）で進める
3. **develop モードの「動作確認」ステップ** → IDE で既に開いているシミュレータを使う or Claude が `xcrun` / `gradlew` でコマンド起動を案内

## プラグインの動作

プラグインの `/cc-development-team:init-dept` でプロジェクト種別「Mobile」を選ぶと、上記のような IDE 併用を前提とした設定（ビルドコマンド・テストコマンド等）が `dept/developer/CLAUDE.md` のテンプレートに反映されます。

`Mobile` を選択して初期化を終えると、画面上で各 IDE の公式ダウンロード URL もすぐに確認できます。
