# SimpleComfyUi

諸々整備中。

NVIDIA ビデオカードを搭載した Windows PC で [ComfyUI](https://github.com/comfyanonymous/ComfyUI) と [ComfyUI Manager](https://github.com/Comfy-Org/ComfyUI-Manager) を `venv` で [マニュアルインストール](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#manual-install-windows-linux) します。

他のカスタムノードのインストールやモデルのダウンロードはしません。

## インストール方法

1. [SimpleComfyUiInstaller.bat](https://github.com/Zuntan03/SimpleComfyUi/raw/main/SimpleComfyUi/SimpleComfyUiInstaller.bat?ver=0) を右クリックから保存します。
2. インストール先の **空フォルダ** を `C:/SimpleComfyUi/` や `D:/SimpleComfyUi/` などの浅いパスに用意して、ここに `SimpleComfyUiInstaller.bat` を移動して実行します。
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
	- **`Microsoft Visual C++ 2015-2022 Redistributable` のインストールで `このアプリがデバイスに変更を加えることを許可しますか？` と表示されたら `はい` とします。**

## 使い方

- `ComfyUi.bat` で起動します。
- `Update.bat` で更新します。

## 仕様

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
