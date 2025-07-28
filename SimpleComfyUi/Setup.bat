@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools
set CURL_CMD=C:\Windows\System32\curl.exe -kL

call %EASY_TOOLS%\ComfyUi\ComfyUi_Update.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

@REM https://github.com/kijai/ComfyUI-Florence2/issues/134
@REM https://github.com/huggingface/transformers/issues/36886
echo pip install -qq transformers==4.49.0
pip install -qq transformers==4.49.0
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM ComfyUI-Impact-Pack\requirements.txt
echo pip install -qq numpy==1.26.4 opencv-python-headless==4.11.0.86 opencv-contrib-python==4.11.0.86 opencv-python==4.11.0.86
pip install -qq numpy==1.26.4 opencv-python-headless==4.11.0.86 opencv-contrib-python==4.11.0.86 opencv-python==4.11.0.86
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

