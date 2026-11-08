@echo off
setlocal
cd /d "%~dp0"
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter belum tersedia di PATH. Pasang Flutter SDK terlebih dahulu.
  pause
  exit /b 1
)
call flutter create --platforms=android --project-name lokasi_flutter --org com.example --no-pub .
if errorlevel 1 exit /b 1
call flutter pub get
if errorlevel 1 exit /b 1
echo Project siap. Jalankan: flutter run
pause
