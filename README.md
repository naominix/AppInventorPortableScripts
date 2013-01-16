App Inventor Portable for Windows Batch files
======================
App Inventor Portable for WindowsはApp InventorのBlocksEditorを起動するために必要な  
環境設定をUSBメモリに格納してしまおうという実験です。  
この環境を実現するために必要なバッチファイルをGitHubで公開しています。  
 
詳細な情報はブログ[App Inventorで行こう！](http://ainaominix.blogspot.jp/) を参照してください。

ご注意
------
バッチファイルの中にはレジストリの変更（管理者権限を利用するものとそうでないもの）を伴うものがあります。
本バッチファイル群をご利用の結果、発生した損害に関しては一切責任を負うことはできませんのでご了承の上ご利用ください。

USBメモリのセットアップ
------
USBメモリの作成方法はブログエントリを参照してください。
なお、App Inventor関連サーバをUSBメモリから起動する場合はJDKを32bitと64bitの両方を入れておくことをオススメします。
バッチファイル内の該当フォルダ名は適宜変更してください。

最新のバッチファイル
------
AIPortableXPto8WithServer.bat

このバッチファイルはユーザ権限でレジストリを変更します。バッチファイルの内容を良く確認してください。
変更対象のレジストリキーがすでに存在している場合は、USBメモリのバッチファイルと同じフォルダに*.regという拡張子で該当レジストリがexportされます。
心配な場合はこのファイルを別の場所にバックアップしておいてください。バッチファイルを終了させてしまうとこれらのファイルは自動的に削除されますのでご注意ください。

App InventorサーバとBuildサーバを起動する場合はバッチファイル中のSERVER環境変数に1をセットしてください。この場合、64bitJavaが必要になりますので忘れずにインストールしてください。

