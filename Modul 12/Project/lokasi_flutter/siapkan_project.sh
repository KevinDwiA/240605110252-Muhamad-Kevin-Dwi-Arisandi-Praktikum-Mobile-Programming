#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
flutter create --platforms=android --project-name lokasi_flutter --org com.example --no-pub .
flutter pub get
printf '%s\n' 'Project siap. Jalankan: flutter run'
