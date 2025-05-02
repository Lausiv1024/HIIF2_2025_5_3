#import "@preview/slydst:0.1.4": *
#import "@preview/showybox:2.0.1": showybox

#set text(font: "Noto Sans JP")
#show regex("[0-9]"): set text(font: "Gill Sans MT") 
// 数字のみ三菱エレベータ化

#show: slides.with(
  title: "BLEを使った簡易的な近距離チャットアプリ",
  subtitle: none,
  authors: "後藤洸樹",
  layout: "medium",
  ratio: 16/9,
  title-color: rgb("#704685")
)

== お品書き
#enum([自己紹介],[作ろうとした理由], [BLEの説明], [作ったもの],
[作ったものの欠点], [今後の展望])

== 自己紹介
- 名前
  - 後藤洸樹
- 所属
  - 摂南大学　電気電子工学科
  - 摂南大学　情報処理技術研究部
- 好きな技術
  - C\#
  - dotnet
  - BLEを使った開発
  - .NET Aspire(普通の開発でも神技術)
- SNS
  - X : \@#text(font: "Gill Sans MT")[lausiv1024]
  - Github : Lausiv1024
- EF Coreに嫌われている
  - 永遠にMigrationができない

== これを作ろうとした理由
- スマホを左手デバイスとして使えるアプリケーションを作っている。
- これに応用できないかと考えたから。

== そもそもBLEとは
- Bluetoothの省電力規格
- IoT等の省電力な用途で使われることが多い
- 基本Gattプロファイルで通信を行う
=== ネットワーク構成
ブロードキャスト方式は今回割愛... \
コネクション方式について説明
==== セントラル(主にクライアント側)
主にPC等がこちらの役割を果たす場合が多い。
\ IoT機器等からデータを受け取る用途に使ったり
==== ペリフェラル(主にサーバ側)
IoTデバイス等がこちらの役割を果たす場合が多い。主に接続してきたセントラルにデータを送信する用途に使われる。

#image("image.png")

== GATT(Generic Attribute Profile)
a
= 早速よくある構成と逆で作りましょう

== デスクトップApp(WPF)
- Peripheralとして動作
- Centralからのデータを受信
- Centralへのデータ送信(Notify機能を利用)
#place(bottom + right,
image("image-1.png", width: 64%)
)
== スマホApp(.NET MAUI)
- Centralとして動作
- Notify機能(ペリフェラルからセントラルへ送信)による通知情報の受信
- データ送信
#place(top + right,
image("Screenshot_20250502-230704.png", width: 20%)
)

== 逆にした理由
スマホ側のライブラリがセントラルとして動作させることを目的に作っており、それに準拠する形で作ったから
=== スマホをセントラルにする欠点
#align(center)[
#text(size: 20pt)[
Write(S→Pの通信)が遅い！！
]
]
とても左手デバイスとして使おうとは思えないレベル。逆にNotifyは割と行ける。
== 今後の展望
=== ペアリング機能
鍵を交換し、以後の通信でその保存した鍵を用いてセキュアな通信をする。
OSの機能に頼らずカスタムプロファイル上に実装する。
=== スマホをペリフェラルとして使う
これが1番早いと思います。