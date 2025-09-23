@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0EasyTools
set EASY_COMFYUI=%EASY_TOOLS%\ComfyUi
set GITHUB_CLONE_OR_PULL_HASH=%EASY_TOOLS%\Git\GitHub_CloneOrPull_Hash.bat
set HUGGING_FACE=%EASY_TOOLS%\Download\HuggingFace.bat
set CURL_CMD=C:\Windows\System32\curl.exe -kL

if exist %EASY_COMFYUI%\ComfyUi_Version.txt ( del %EASY_COMFYUI%\ComfyUi_Version.txt )
if exist %EASY_COMFYUI%\ComfyUiManager_Version.txt ( del %EASY_COMFYUI%\ComfyUiManager_Version.txt )

call "%~dp0Update.bat"
if %ERRORLEVEL% neq 0 ( exit /b 1 )

pushd "%~dp0"

popd rem "%~dp0"
pushd "%~dp0ComfyUI\custom_nodes"

@REM https://github.com/AlekPet/ComfyUI_Custom_Nodes_AlekPet/commits/master/
call :GITHUB_HASH_REQUIREMENTS AlekPet ComfyUI_Custom_Nodes_AlekPet master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/city96/ComfyUI-GGUF/commits/main/
call :GITHUB_HASH_REQUIREMENTS city96 ComfyUI-GGUF main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

REM https://github.com/kijai/ComfyUI-KJNodes/commits/main/
call :GITHUB_HASH_REQUIREMENTS kijai ComfyUI-KJNodes main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/rgthree/rgthree-comfy/commits/main/
call :GITHUB_HASH_REQUIREMENTS rgthree rgthree-comfy main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem "%~dp0ComfyUI\custom_nodes"
pushd "%~dp0ComfyUI\models\unet"

@REM https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF
call %HUGGING_FACE% QIE2509\ Qwen-Image-Edit-2509-Q3_K_M.gguf QuantStack/Qwen-Image-Edit-2509-GGUF
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )
call %HUGGING_FACE% QIE2509\ Qwen-Image-Edit-2509-Q5_K_M.gguf QuantStack/Qwen-Image-Edit-2509-GGUF
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem "%~dp0ComfyUI\models\unet"
pushd "%~dp0ComfyUI\models\text_encoders"

@REM https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI
call %HUGGING_FACE% .\ qwen_2.5_vl_7b_fp8_scaled.safetensors Comfy-Org/Qwen-Image_ComfyUI split_files/text_encoders/
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM RuntimeError: mat1 and mat2 shapes cannot be multiplied (784x1280 and 3840x1280)
@REM https://huggingface.co/unsloth/Qwen2.5-VL-7B-Instruct-GGUF
@REM call %HUGGING_FACE% Qwen2.5-VL-7B-Instruct-GGUF\ Qwen2.5-VL-7B-Instruct-Q4_K_M.gguf unsloth/Qwen2.5-VL-7B-Instruct-GGUF
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )
@REM call %HUGGING_FACE% Qwen2.5-VL-7B-Instruct-GGUF\ mmproj-BF16.gguf unsloth/Qwen2.5-VL-7B-Instruct-GGUF
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem "%~dp0ComfyUI\models\text_encoders"
pushd "%~dp0ComfyUI\models\vae"

@REM https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI
call %HUGGING_FACE% .\ qwen_image_vae.safetensors Comfy-Org/Qwen-Image_ComfyUI split_files/vae/
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem "%~dp0ComfyUI\models\vae"
pushd "%~dp0ComfyUI\models\loras"

@REM https://huggingface.co/lightx2v/Qwen-Image-Lightning
call %HUGGING_FACE% Fast\ Qwen-Image-Edit-Lightning-8steps-V1.0-bf16.safetensors lightx2v/Qwen-Image-Lightning
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )
call %HUGGING_FACE% Fast\ Qwen-Image-Edit-Lightning-4steps-V1.0-bf16.safetensors lightx2v/Qwen-Image-Lightning
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem "%~dp0ComfyUI\models\loras"
pushd "%~dp0ComfyUI\input"
if exist GQuX-Nyaan_Machu.webp ( goto :EXIST_INPUT_IMG )

echo %CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/GQuX-Nyaan_Machu.webp
%CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/GQuX-Nyaan_Machu.webp

echo %CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/ApoHotel-Yachiyo.webp
%CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/ApoHotel-Yachiyo.webp

:EXIST_INPUT_IMG
popd rem "%~dp0ComfyUI\input"

if not exist "%~dp0ComfyUI\user\default\workflows\" ( mkdir "%~dp0ComfyUI\user\default\workflows" )
pushd "%~dp0ComfyUI\user\default\workflows"

echo %CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/QwenImageEdit2509.json
%CURL_CMD% -O https://yyy.wpx.jp/SimpleComfyUi/QwenImageEdit2509.json

popd rem "%~dp0ComfyUI\user\default\workflows"
exit /b 0

:GITHUB_HASH_REQUIREMENTS
set "GITHUB_AUTHOR=%1"
set "GITHUB_REPO=%2"
set "GITHUB_BRANCH=%3"
set "GITHUB_HASH=%4"

call %GITHUB_CLONE_OR_PULL_HASH% %GITHUB_AUTHOR% %GITHUB_REPO% %GITHUB_BRANCH% %GITHUB_HASH%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

if exist %GITHUB_REPO%\requirements.txt (
	setlocal enabledelayedexpansion
	echo pip install -qq -r %GITHUB_REPO%\requirements.txt
	pip install -qq -r %GITHUB_REPO%\requirements.txt
	if !ERRORLEVEL! neq 0 ( pause & endlocal & exit /b 1 )
	endlocal
)
exit /b 0
