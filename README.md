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
	- 初回起動時にブラウザキャッシュにある過去のワークフローが開かれ、エラーになる場合があります。エラーを無視してワークフローを閉じてください。
- `Update.bat` で更新します。
	- `Update.bat` の実行前に `EasyTools/ComfyUi/` にある `ComfyUi_LatestVersion.bat` や `ComfyUiManager_LatestVersion.bat` を実行しておくと、その時点での最新リリースバージョンに更新できます。

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

## [Kijai/WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper) の導入手順

2025/07/29 の夕方時点で、Geforce RTX 3060 VRAM 12GB, RAM 64GB 環境において `512x768` の 81frame を 7分程度で生成できています。  
Kijai/WanVideoWrapper が絶賛開発中ですので以下の情報がすぐに古くなる可能性が高いです。

1. [example_workflows/](https://github.com/kijai/ComfyUI-WanVideoWrapper/tree/main/example_workflows) から利用したいワークフローをダウンロードします。
	- [wanvideo2_2_I2V_A14B_example_WIP.json](https://github.com/kijai/ComfyUI-WanVideoWrapper/raw/refs/heads/main/example_workflows/wanvideo2_2_I2V_A14B_example_WIP.json) を右クリックから保存。  
	ファイル名の通り WIP なので近日中にリンク切れになる可能性が高いです。
2. `ComfyUi.bat` で起動して、ワークフローをドラッグ＆ドロップで開きます。
3. `Missing Node Types` が表示されるので、下の `Open Manager` を開いてから、右上の `すべての不足しているノードをインストール`（ラベルに見えますがボタンです）します。
	- インストールが終わると、下に `変更を適用するには、ComfyUIを再起動してください` と表示されるので `再起動` します。
4. 再起動が完了したら `実行する` でファイルが不足しているエラーが表示されますので、必要なファイルをダウンロードします。
	- `oldman_upscaled.png` はお好みの画像をドラッグ＆ドロップします。
		- 画像の内容に合わせて `WanVideo TextEncode` のプロンプトを書き換えます。
	- [Wan2_2-I2V-A14B-HIGH_fp8_e4m3fn_scaled_KJ.safetensors](https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e4m3fn_scaled_KJ.safetensors) と [Wan2_2-I2V-A14B-LOW_fp8_e4m3fn_scaled_KJ.safetensors](https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e4m3fn_scaled_KJ.safetensors) を `ComfyUI/models/diffusion_models/WanVideo/2_2/` フォルダに置きます。
	- [lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors](https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors) を `ComfyUI/models/loras/WanVideo/Lightx2v/` フォルダに置きます。
	- [umt5-xxl-enc-bf16.safetensors](https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors) を `ComfyUI/models/clip/` フォルダに置きます。
	- [Wan2_1_VAE_bf16.safetensors](https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors) を `ComfyUI/models/vae/wanvideo/` フォルダに置きます。  
	7/29 時点のワークフローでは、Wan 2.2 でなく Wan 2.1 の VAE が利用されています。
		- Wan 2.2 版 [wan2.2_vae.safetensors](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors)
5. ファイルをダウンロードしたら `実行する` で動画を生成します。
	- パソコンのスペックが十分出なかった場合はエラーが表示されます。  
	次の『Geforce RTX 3060 12GB での Kijai/WanVideoWrapper サンプル動作』を参考に対処してください。

`Video Combine` の `frame_rate` は `24` が正しいかもしれません。

### Geforce RTX 3060 12GB での [Kijai/WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper) サンプル動作

- `WanVideo TextEncode` でエラーが出る場合は、`WanVideo T5 Text Encoder Loader` の `quantization` を `fp8_e4m3fn` にします。
	- [umt5-xxl-enc-fp8_e4m3fn.safetensors](https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors) を代わりに利用するとメインメモリの消費を抑えられます。
- Geforce RTX 30x0 ではふたつの `WanVideo Model Loader` で [Wan2_2-I2V-A14B-HIGH_fp8_e5m2_scaled_KJ.safetensors](https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e5m2_scaled_KJ.safetensors) と [Wan2_2-I2V-A14B-LOW_fp8_e5m2_scaled_KJ.safetensors](https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e5m2_scaled_KJ.safetensors) を代わりに利用し、 `quantization` を `fp8_e5m2_scaled` に変更します。
	- もしくは `WanVideo Torch Compile Settings` を `Ctrl+B` でミュートします。
- `WanVideo Block Swap` の `blocks_to_swap` を `40` に、`offload_img_emb` と `offload_txt_emb` を `true` にします。
- まだ VRAM が足りない場合は `WanVideo ImageToVideo Encode` の `num_frames` を減らしたり、`Resize Image v2` の `width` や `height` を減らしたりします。

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
