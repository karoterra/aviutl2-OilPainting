# AviUtl スクリプト - 油絵KR

Kuwahara filter により油絵風の加工を施す
[AviUtl2](http://spring-fragrance.mints.ne.jp/aviutl/) スクリプトです。

[AviUtl1 用の油絵スクリプト](https://github.com/karoterra/aviutl-OilPainting) を AviUtl2 用に移植したものです。

高橋直哉氏の[油絵スクリプト](https://www.nicovideo.jp/watch/sm35695116)の処理速度を向上させたものです。

## 動作環境

AviUtl ExEdit2 version 2.0beta1 にて動作確認しました。

## 導入方法

1. [Releases](https://github.com/karoterra/aviutl2-OilPainting/releases/) から最新版の ZIP ファイルをダウンロードしてください。
2. ZIP ファイルを展開し、以下のファイルを `C:\ProgramData\aviutl2\Script\` または `C:\ProgramData\aviutl2\Script\<任意の名前>\` に配置してください。
   - `油絵KR.anm2`

## 使い方

お好きなオブジェクトにアニメーション効果「油絵KR」を適用してください。
デフォルトでは「加工」カテゴリの中にあります。

- ぼかし: ぼかしの強さ(0だと変化なし)
- 輝度モード: ピクセルの輝度の計算方法
  - スクリプトの内部処理で輝度を計算する箇所があり、その計算方法を選択します
  - 輝度モードによってアニメーション効果適用後の雰囲気が変わる場合があります。

## License

このソフトウェアは MIT ライセンスのもとで公開されます。
詳細は [LICENSE](LICENSE) を参照してください。

## Credits

このスクリプトは高橋直哉氏の[油絵スクリプト](https://www.nicovideo.jp/watch/sm35695116)の処理速度向上を目的として開発したものです。

## Change Log
