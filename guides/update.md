# プラグインの更新方法

GitHub 側のプラグイン本体に更新が入った場合、**インストール済みのプラグインは自動更新されません**。手元で最新版を反映するには以下を順に実行してください（`/plugin update` という単独コマンドは存在しないため、アンインストール→マーケットプレース更新→再インストールの 3 ステップで行います）。

> **ショートカット:** `/cc-development-team:update` を実行すると、**GitHub と照合して「最新です」か「更新があります」かを自動判定** します。古ければそのまま下の 3 コマンドが表示されるので、コピペして実行してください（自動実行はされません）。

## 3 ステップで更新

```
# 1. 一度アンインストール
/plugin uninstall cc-development-team
```

```
# 2. マーケットプレース情報を最新化
/plugin marketplace update cc-development-team
```

```
# 3. 再インストール
/plugin install cc-development-team@cc-development-team
```

更新後、コマンド定義の再読み込みのために **Claude Code を再起動** すると確実です（`Ctrl+D` で抜けて `claude` で起動し直す）。

## UI から操作する方法

`/plugin` を実行するとプラグインブラウザ UI が開きます。

1. Tab キーで **「Installed」タブ** に移動
2. `cc-development-team` を選択
3. 表示される操作メニューから再インストールを選ぶ

## 更新が反映されたか確認

`/cc-development-team:init-dept` を実行したときに **「このプロジェクトは Web 開発か Mobile 開発か」のヒアリング** が出れば最新版です。出ない場合は古い版のままなので、上記の手順をやり直してください。
