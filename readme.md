# PAServer.sh

これは Delphi/C++Builder/RAD StudioでiOS/macOS/Linux開発の際に
使用するPAServerを複数バージョンインストールしている場合に
実行するバイナリを対話的に選択できるUIを提供するラッパーです。

macOS では /Application フォルダにインストール済みの
複数のPAServerを探します。

Linuxでは ~/PAServer-* を対象に探します。

peco or percol をインストールしていればとても便利になりますが、
これらがなくてもそれなりに便利に使えます 

PAServer selective launcher with interactive interface.
if you have peco or percol by installing homebrew,
you can edit shell env "interactive_helper"
to put fullpath for it.

# 実行例/Exanples to run
## peco と組み合わせた場合/with peco on macOS
![paserver_launcher_script1.gif](https://qiita-image-store.s3.amazonaws.com/0/149350/977fe6b1-1c31-ad1c-cd23-ad2d1baa760a.gif)

## peco や percol がない場合/no peco or percol on macOS
![paserver_launcher_script2.gif](https://qiita-image-store.s3.amazonaws.com/0/149350/b4d89b2a-5764-2cea-0462-473b15fc917c.gif)
