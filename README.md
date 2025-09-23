# SimpleComfyUi

[English README](README_en.md)

NVIDIA ビデオカードを搭載した Windows PC で [ComfyUI](https://github.com/comfyanonymous/ComfyUI) と [ComfyUI Manager](https://github.com/Comfy-Org/ComfyUI-Manager) を `venv` で [マニュアルインストール](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#manual-install-windows-linux) します。

他のカスタムノードのインストールやモデルのダウンロードはしません。

## Portable Package との主な違い

- `ComfyUI Manager` をインストールします。
- `triton` や `SageAttention` をインストールします。
- `python_embeded` 直接でなく `venv` 経由で利用します。

## インストール方法

1. [SimpleComfyUiInstaller.bat](https://github.com/Zuntan03/SimpleComfyUi/raw/main/SimpleComfyUi/SimpleComfyUiInstaller.bat?ver=0) を右クリックから保存します。
2. インストール先の **空フォルダ** を `C:/SimpleComfyUi/` や `D:/SimpleComfyUi/` などの浅いパスに用意して、ここに `SimpleComfyUiInstaller.bat` を移動して実行します。
	- **`発行元を確認できませんでした。このソフトウェアを実行しますか？` と表示されたら `実行` します。**
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
	- **`Microsoft Visual C++ 2015-2022 Redistributable` のインストールで `このアプリがデバイスに変更を加えることを許可しますか？` と表示されたら `はい` とします。**

## 使い方

- `ComfyUi.bat` で起動します。
	- 初回起動時にブラウザキャッシュにある過去のワークフローが開かれ、エラーになる場合があります。エラーを無視してワークフローを閉じてください。
- `Update.bat` で更新します。
	- `Update.bat` の実行前に `EasyTools/ComfyUi/` にある `ComfyUi_LatestVersion.bat` や `ComfyUiManager_LatestVersion.bat` を実行しておくと、その時点での最新リリースバージョンに更新できます。

## 仕様

- `ComfyUi_Activate.bat` で `venv\Scripts\activate` したコンソールを開きます。
- Git にパスが通っていれば利用し、無ければポータブル版をインストールします。
- Python は 3.10.x にパスが通っていれば利用し、無ければポータブル版をインストールします。
- ComfyUI と ComfyUI Manager は、インストール時にリリースされている最新バージョンをインストールします。
	- バージョンを変更したい場合は `EasyTools/ComfyUi/` にある `ComfyUi-Version.txt` と `ComfyUiManager-Version.txt` の内容をリリース済みバージョンに変更してください。
	- `ComfyUi-Version.txt` や `ComfyUiManager-Version.txt` を削除すると、リポジトリの最新リビジョンに更新します。
- `pip` で `venv` に各種モジュールをインストールします。
	- `torch`, `torchvision`, `torchaudio`
	- `triton`, `sageattention`

<!--
README.md を英訳して、更新箇所に合わせて README_en.md を更新します。主に『主な更新』を更新します。
-->

## 主な更新

### 2025/09/23

-  [Qwen-Image-Edit-2509](https://huggingface.co/Qwen/Qwen-Image-Edit-2509) を簡単に試せる `Setup-QwenImageEdit2509.bat` を追加しました。
	- セットアップの実行後に、ワークフローの `QwenImageEdit2509.json` で QwenImageEdit を利用できます。
	- 主に緑色のノードを操作します。
	- `TranslatePrompt` は日本語プロンプトを英訳します。
	- 旬が過ぎたら削除します。

### 2025/09/20

- デフォルトのバージョンを安定動作に実績のあるバージョンに変更しました。
	- Python 3.10
	- PyTorch 2.7.1+cu2.8.0
	- SageAttention をコマンドラインオプションから削除。
		- ノードで有効にするか、`ComfyUi.bat` を別名コピーして、引数に `--use-sage-attention` を追加。

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。  
別途ライセンスファイルがあるフォルダ以下は、そのライセンスです。
