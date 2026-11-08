@echo off
setlocal
cd /d "%~dp0"
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter SDK belum tersedia di PATH.
  pause
  exit /b 1
)
call flutter create --platforms=android,web --project-name flutter_crud_api --org com.example --no-pub .
if errorlevel 1 (
  pause
  exit /b 1
)
call flutter pub get
if errorlevel 1 (
  pause
  exit /b 1
)
echo Project siap. Jalankan flutter run dan pilih perangkat.
pause
