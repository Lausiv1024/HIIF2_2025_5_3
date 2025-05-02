#import "@preview/slydst:0.1.4": *
#import "@preview/showybox:2.0.1": showybox

#set text(font: "Noto Sans JP")
#show regex("[0-9]"): set text(font: "Gill Sans MT") // 数字のみ三菱エレベータ化

#show: slides.with(
  title: "BLEを使った簡易的な近距離チャットアプリ",
  subtitle: none,
  authors: "後藤洸樹",
  layout: "medium",
  ratio: 16/9,
  title-color: rgb("#704685")
)

== 目次
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
  - X : \@lausiv1024
  - Github : Lausiv1024

== これを作ろうとした理由
- スマホを左手デバイスとして使えるアプリケーションを作っている。
- これに応用できないかと考えたから。
#place(bottom + right,
image("SPApp.png"))

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

== BLEの通信方法
=== Service
機能の単位で作られる定義
\ 例：キーボード単体
=== Characteristic
実際にやり取りするデータが入る場所
\ 例：押されたキーの情報
#place(bottom + right,
image("image-2.png", width: 50%)
)
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
* Write(S→Pの通信)が遅い！！ *
]
]
とても左手デバイスとして使おうとは思えないレベル。逆にNotifyは割と行ける。

== ペアリング機能(現在実装中)
BouncyCastleを用いたECDH鍵合意機能を用いて、公開鍵の交換と計算で共通鍵を導出。
これで導出された共通鍵をペアリングの鍵として使用したい。\
BouncyCastleに頼っているものの楕円曲線暗号に対応している。
=== 現状迷っていること
- 果たしてこの暗号技術で大丈夫なのか
  - 中間者攻撃の懸念
  - その他セキュリティ関係の穴

== 今後の展望
=== スマホをペリフェラルとして使う
遅延の問題に対してはこれが1番早いと思います。
== 使用したライブラリ・フレームワーク
=== Mobile App
- .NET MAUI
- #link("https://github.com/dotnet-bluetooth-le/dotnet-bluetooth-le/tree/master")[Bluetooth LE plugin for Xamarin & MAUI]
== 今回紹介したプロジェクト
今回紹介したプロジェクトは以下のリンクから確認できます。 \
ペアリング機能を実装中(ブランチ名がMessagePackだけど気にしないで) \
#link("https://github.com/Lausiv1024/BLETest")[BLETest]