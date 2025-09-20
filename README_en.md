# SimpleComfyUi

[日本語 README](README.md)

[Manual installation](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#manual-install-windows-linux) of [ComfyUI](https://github.com/comfyanonymous/ComfyUI) and [ComfyUI Manager](https://github.com/Comfy-Org/ComfyUI-Manager) using `venv` on Windows PC with NVIDIA graphics card.

Does not install other custom nodes or download models.

## Main differences from Portable Package

- Installs `ComfyUI Manager`.
- Installs `triton` and `SageAttention`.
- Uses `venv` instead of directly using `python_embeded`.

## Installation

1. Right-click and save [SimpleComfyUiInstaller.bat](https://github.com/Zuntan03/SimpleComfyUi/raw/main/SimpleComfyUi/SimpleComfyUiInstaller.bat?ver=0).
2. Prepare an **empty folder** at a shallow path like `C:/SimpleComfyUi/` or `D:/SimpleComfyUi/` as the installation destination, move `SimpleComfyUiInstaller.bat` here and run it.
	- **If you see `Publisher could not be verified. Do you want to run this software?`, click `Run`.**
	- **If you see `Windows protected your PC`, click `More info` then `Run anyway`.**
	- **If you see `Do you want to allow this app to make changes to your device?` during `Microsoft Visual C++ 2015-2022 Redistributable` installation, click `Yes`.**

## Usage

- Launch with `ComfyUi.bat`.
	- On first launch, past workflows in browser cache may open and cause errors. Please ignore the errors and close the workflow.
- Update with `Update.bat`.
	- Before running `Update.bat`, execute `ComfyUi_LatestVersion.bat` or `ComfyUiManager_LatestVersion.bat` in `EasyTools/ComfyUi/` to update to the latest release version at that time.

## Specifications

- `ComfyUi_Activate.bat` opens a console with `venv\Scripts\activate` activated.
- Uses Git if it's in PATH, otherwise installs portable version.
- Uses Python 3.10.x if it's in PATH, otherwise installs portable version.
- ComfyUI and ComfyUI Manager install the latest version released at the time of installation.
	- To change versions, modify the contents of `ComfyUi-Version.txt` and `ComfyUiManager-Version.txt` in `EasyTools/ComfyUi/` to released versions.
	- Deleting `ComfyUi-Version.txt` or `ComfyUiManager-Version.txt` will update to the latest revision of the repository.
- Installs various modules to `venv` with `pip`.
	- `torch`, `torchvision`, `torchaudio`
	- `triton`, `sageattention`

<!--
README.md を英訳して README_en.md を更新します。
-->

## Major Updates

### 2025/09/20

- Changed default versions to those with proven stable operation.
	- Python 3.10
	- PyTorch 2.7.1+cu2.8.0
	- Removed SageAttention from command line options.
		- Enable it in nodes, or copy `ComfyUi.bat` with a different name and add `--use-sage-attention` to the arguments.

## License

The contents of this repository are under [MIT License](./LICENSE.txt).  
Folders with separate license files follow those licenses.
