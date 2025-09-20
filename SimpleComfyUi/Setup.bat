@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools
set CURL_CMD=C:\Windows\System32\curl.exe -kL

pushd %~dp0..

call %EASY_TOOLS%\ComfyUi\ComfyUi_Update.bat
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/kijai/ComfyUI-Florence2/issues/134
@REM https://github.com/huggingface/transformers/issues/36886
@REM echo pip install -qq transformers==4.49.0
@REM pip install -qq transformers==4.49.0
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM ComfyUI-Impact-Pack\requirements.txt
echo pip install -qq numpy==1.26.4 opencv-python-headless==4.11.0.86 opencv-contrib-python==4.11.0.86 opencv-python==4.11.0.86
pip install -qq numpy==1.26.4 opencv-python-headless==4.11.0.86 opencv-contrib-python==4.11.0.86 opencv-python==4.11.0.86
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM https://github.com/Zuntan03/EasyWan22/issues/1 Python 3.12.x, ModuleNotFoundError: No module named 'yaml'
echo pip install -qq PyYAML==6.0.2
pip install -qq PyYAML==6.0.2
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

popd rem %~dp0..
