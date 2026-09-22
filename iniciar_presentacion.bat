@echo off
title FitManager Pro - Servidor de Presentacion
chcp 65001 > nul
echo ======================================================================
echo           FITMANAGER PRO - PRESENTACION TALLER DE BASE DE DATOS
echo ======================================================================
echo.
echo  Iniciando servidor local para habilitar todos los reproductores y APIs...
echo  Abriendo: http://localhost:8000
echo.
echo  [CONSEJO] Al ejecutarse como servidor web local, el video de YouTube
echo            se reproduce perfectamente sin restricciones de seguridad (Error 153).
echo.
echo  Para detener el servidor, cierra esta ventana o presiona Ctrl + C.
echo ======================================================================
echo.

start http://localhost:8000

python -m http.server 8000
if %errorlevel% neq 0 (
    echo.
    echo No se pudo iniciar el servidor con Python. Abriendo archivo HTML directamente...
    start index.html
    pause
)
