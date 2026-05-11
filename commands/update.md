---
description: cc-DevelopmentTeam プラグインを最新版に更新する手順を表示する
---

このコマンドは **手順を表示するだけ** です（プラグインがランタイム組み込みコマンド `/plugin uninstall` 等を直接呼び出すことはできないため）。表示された 3 つのコマンドを **ユーザー自身が順番にコピペ実行** してください。

ユーザーに以下を出力してください（このまま整形して表示すること）:

```
【cc-DevelopmentTeam プラグインの更新手順です!】

以下 3 つのコマンドを順番にコピペして実行してくださいね!

  /plugin uninstall cc-development-team

  /plugin marketplace update cc-development-team

  /plugin install cc-development-team@cc-development-team

実行後、念のため Claude Code を再起動すると確実です!（Ctrl+D で抜けて `claude` で再起動）

[反映確認]
/cc-development-team:design を引数なしで実行し、「A: アプリ構想モード / B: 機能設計モード」のモード選択が出れば最新版です!
```

補足案内（必要に応じて追加で表示）:

- 反映されない場合は Claude Code の再起動を試す
- それでも古い挙動なら GitHub リポジトリで最新コミットを確認: https://github.com/miyazakiryuji/cc-DevelopmentTeam

このコマンド自体は実行・確認・自動化を行わず、上記の手順を案内する**だけ**で終わってよい。
