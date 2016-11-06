# GROOVE
## 製品概要
### エンタメ x Tech

### 背景（製品開発のきっかけ、課題等）
コンサートやストリートダンスにおける演出は人手や手間を要する.
例えば

* 音響
* 背景の動画
* 照明
* 撮影

は, 他者との事前打ち合わせや, プログラミングを通して行われている.
さらに演者である自身は演出装置の制御が困難であり, 演出を通して自身を表現する場合には, 演出装置の制御をスタッフに委託する必要がある．そのため, **スタッフを雇えないアマチュアダンサー・ストリートダンサーにとって, ダンスバトルのような即興アドリブのダンスでは自身の表現力を最大限に活かせない.** そのような課題意識の元で, ダンサーが自身の演出を制御でき, 観衆を盛り上げることができるデバイスの開発を行った.


### 製品説明（具体的な製品の説明）
GROOVEは手袋型のリアルタイムなイベント・ダンス支援システムであり，手袋をはめて行動するだけで演出を制御し, 盛り上げることができる．
演出制御はセンサーデータと装置を通信することによって行う.
主な演出は,
* **センサーデータとGROOVEのLEDを対応させることで, 手の動きで点灯パターンを制御する.**
* **センサーデータと演出管理のPCを対応させることで, ダンサーの背後の背景や, 曲の音響を制御する.**

またダンスの動画の撮影の制御を通し, 演出に使った制御データや動画を共有するSNSを構築した.

### 特長
#### 1. センシング
グローブに搭載されている加速度・ジャイロ・曲げ・圧力センサから各種値を取得する. その取得したデータをリアルタイムにBluetoothで発信し続ける.

#### 2. LEDテープとその制御による鮮やかな演出
センサーの取得値に応じてグローブのLEDの明滅パターンを制御する. ダンサーの小宮と協議を重ね, ダンサーの直感にあう明滅パターンを構築した.

#### 3. センサーの取得値を利用した演出パターンの生成
ChangeFinder法により学習データのアノテーションを行い, ディープラーニングを用いることで，センサーの値とダンサーの動きや技を紐づける. その結果, ストリートダンスにおける様々な技に応じて, 音響や背景画像を操作することができる．(例えば手を捻る動きで, 音響にイコライズをかけられる等)

### 解決出来ること
**「一人ではダンスの演出を即興で制御できない」を解決します**

従来，コンサートやストリートダンスにおいて音響や背景演出はスタッフとの打ち合わせやプログラミングが事前に行わている．
さらにリアルタイムな演出のためには，他者に演出装置を操作してもらう必要がある．
**このGROOVEを使えば，ダンスしている自身がリアルタイムかつ直接的に音響・演出を制御することが可能である．**

### 今後の展望
音響・背景演出・照明演出のコントロールをもっと直感的かつ容易にしたい.

### 注力したこと（こだわり等）
* リチウムポリマー電池による安定した電源供給とその制御
* 点滅パターンの割り込み処理. 平常時の明滅パターンを保ったまま, イベントごとの点滅パターンを実行できる.(イベントが割り込みが行われても、点滅パターンを音楽のBPMと同期し続けられる)
* SNSにおける認証. SPA構成のためアクセストークン経由でログインを制御している.

## 開発技術
### 活用した外部技術
#### API・データ
* ダンサー小宮によるダンスログ

#### フレームワーク・ライブラリ・モジュール
* chainer
  - DNN
* R
  - ChangeFinder
    + 異常検知, 変化点検知
* C++
  - openFrameworks
* Swift
  - OSX Application
* Vue.js
  - Vuex
  - vue-resource
  - vue-router
* Ruby on Rails
  - carrierwave
  - fog
  - sorcery
* AWS(S3)

#### デバイス
* マイコン
  - Arduino nano(ATmega328)
* センサ
  -  6軸センサ（加速度、ジャイロ）
  - 曲げセンサ
  - 圧力センサ
* LED
  - Adafruit NeoPixel Strip
  - Adafruit NeoPixel Ring
* BLE

### 独自技術
#### 期間中に開発した独自機能・技術
* さらなる小型化のための基礎研究として, 導電性の糸を手袋に縫い付け回路を構築しLEDの点滅を行った.
