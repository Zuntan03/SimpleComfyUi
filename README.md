# SimpleComfyUi

諸々整備中。

NVIDIA ビデオカードを搭載した Windows PC で [ComfyUI](https://github.com/comfyanonymous/ComfyUI) と [ComfyUI Manager](https://github.com/Comfy-Org/ComfyUI-Manager) を `venv` で [マニュアルインストール](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#manual-install-windows-linux) します。

他のカスタムノードのインストールやモデルのダウンロードはしません。

## Portable Package との主な違い

- `ComfyUI Manager` をインストールします。
- `triton` や `SageAttention` をインストールします。
- トラブりがちなモジュール依存を予防します。
- `python_embeded` 直接でなく `venv` 経由で利用します。

## インストール方法

1. [SimpleComfyUiInstaller.bat](https://github.com/Zuntan03/SimpleComfyUi/raw/main/SimpleComfyUi/SimpleComfyUiInstaller.bat?ver=0) を右クリックから保存します。
2. インストール先の **空フォルダ** を `C:/SimpleComfyUi/` や `D:/SimpleComfyUi/` などの浅いパスに用意して、ここに `SimpleComfyUiInstaller.bat` を移動して実行します。
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
	- **`Microsoft Visual C++ 2015-2022 Redistributable` のインストールで `このアプリがデバイスに変更を加えることを許可しますか？` と表示されたら `はい` とします。**

## 使い方

- `ComfyUi.bat` で起動します。
- `Update.bat` で更新します。

## [Wan2.2 Day-0 Support in ComfyUI](https://blog.comfy.org/p/wan22-day-0-support-in-comfyui) 手順

Geforce RTX 3060 12GB & RAM 64GB 環境（RAM は 32GB でも動きそう）で [ComfyUI 公式 Wan 2.2 Day0 記事](https://blog.comfy.org/p/wan22-day-0-support-in-comfyui) の "Wan 2.2 5B Video Generation" を動かせました。以下公式そのまんまな手順。

1. SimpleComfyUi をインストールして `ComfyUi.bat` で起動します。
2. （左ではなく）上部メニューの `ワークフロー` - `テンプレートを参照` を選択。
3. ダイアログ左側の `ビデオ` 選択で、右側の `Wan 2.2 5B Video Generation` を選択。
4. 足りないモデルが 3種類表示されるので、それぞれダウンロードして配置。
	- `wan2.2_ti2v_5B_fp16.safetensors` は `ComfyUI/models/diffusion_models` に配置。
	- `umt5_xxl_fp8_e4m3fn_scaled.safetensors` は `ComfyUI/models/clip` に配置。
	- `wan2.2_vae.safetensors` は `ComfyUI/models/vae` に配置。
5. `実行` で生成された動画が `output/video/` に保存されます。

I2V は VRAM 消費が大きいようで、`拡散モデルを読み込む` の `重みdtype` を `fp8_e4m3fn` にしたら動きました。  
解像度やフレーム数を下げてみても良いかもしれません。

## 仕様

- `ComfyUi_Activate.bat` で `venv\Scripts\activate` したコンソールを開きます。
- Git にパスが通っていれば利用し、無ければポータブル版をインストールします。
- Python は 3.12.x にパスが通っていれば利用し、無ければポータブル版をインストールします。
- ComfyUI と ComfyUI Manager は、インストール時にリリースされている最新バージョンをインストールします。
	- バージョンを変更したい場合は `EasyTools/ComfyUi/` にある `ComfyUi-Version.txt` と `ComfyUiManager-Version.txt` の内容をリリース済みバージョンに変更してください。
	- `ComfyUi-Version.txt` や `ComfyUiManager-Version.txt` を削除すると、リポジトリの最新リビジョンに更新します。
- `pip` で `venv` に各種モジュールをインストールします。
	- `torch`, `torchvision`, `torchaudio`
	- `triton`, `sageattention`
	- 他、トラブルが起きがちなモジュール

<!-- ## トラブルシューティング -->

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。  
別途ライセンスファイルがあるフォルダ以下は、そのライセンスです。
