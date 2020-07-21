# PAServer.sh

これは Delphi/C++Builder/RAD StudioでiOS/macOS/Linux向け開発で
IDEからmacOS/Linux環境にビルドしたアプリをコピーしてデバッグ実行したり
SDK情報をIDEにコピーするために必要なブリッジサーバ PAServer を
実行するためのラッパースクリプトです。

PAServerはDelphi/C++Builder/RAD Studioのメジャーバージョンや
サブスクリプションアップデートごとに異なるバイナリを組み合わせるため、
開発用途によっては複数のバージョン違いのPAServerをmacOSやLinuxに
インストールして使用します。

これをmacOSのLaunchPadから選択して起動するのはスマートな方法とは思えないため、
ターミナル上からコマンド実行して対話的にPAServerを選択実行できるランチャーの
シェルスクリプトを実装しました。

ベースのスクリプトは以前に https://qiita.com/kazinoue/items/583f3271fe96ee8d1b6d で
記事化したコードをですが、これをGithubリポジトリに移管し、いくつかのアップデートを加えています。

# 使用方法

PAServer.sh をパスの通った適当な場所にインストールして実行するだけです。
peco や percol をインストール済みの場合はスクリプト内の interactive_helper に記述しておくと
実行するPAServerの選択がよりスマートに行えます。

# 内部動作

macOS では /Application フォルダにインストール済みの
複数のPAServerを探します。

Linuxでは ~/PAServer-* を対象に探します。

また、~/.paserverrc が存在する場合は PAServer の設定ファイルとみなして自動的に読み込みます。

設定可能な項目は下記ページを参考にしてください。設定ファイルのサンプル例は、このリポジトリの .paserverrc をご利用いただけます。
http://docwiki.embarcadero.com/RADStudio/ja/%E3%83%97%E3%83%A9%E3%83%83%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A0_%E3%82%A2%E3%82%B7%E3%82%B9%E3%82%BF%E3%83%B3%E3%83%88_%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC_%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%EF%BC%9A_PAServer

# 実行例/Exanples to run
## peco と組み合わせた場合/with peco on macOS
![paserver_launcher_script1.gif](https://qiita-image-store.s3.amazonaws.com/0/149350/977fe6b1-1c31-ad1c-cd23-ad2d1baa760a.gif)

## peco や percol がない場合/no peco or percol on macOS
![paserver_launcher_script2.gif](https://qiita-image-store.s3.amazonaws.com/0/149350/b4d89b2a-5764-2cea-0462-473b15fc917c.gif)
