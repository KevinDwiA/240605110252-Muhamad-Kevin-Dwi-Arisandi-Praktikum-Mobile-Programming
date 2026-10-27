$ErrorActionPreference = 'Stop'
$sourceFolder = $PSScriptRoot
$destination = Join-Path (Split-Path $sourceFolder -Parent) 'rasa_app'
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw 'Flutter tidak ditemukan. Tambahkan Flutter SDK/bin ke PATH lalu buka ulang terminal.'
}
if (Test-Path $destination) {
  throw "Folder $destination sudah ada. Pindahkan/ubah nama folder tersebut agar kode Anda tidak tertimpa."
}
flutter create --project-name rasa --platforms=android,web $destination
if ($LASTEXITCODE -ne 0) { throw 'flutter create gagal. Periksa pesan di atas.' }
# Replace only the newly generated example; never modify an existing project.
Remove-Item (Join-Path $destination 'lib') -Recurse -Force
Copy-Item (Join-Path $sourceFolder 'lib') $destination -Recurse
Copy-Item (Join-Path $sourceFolder 'pubspec.yaml') $destination -Force
Copy-Item (Join-Path $sourceFolder 'README.md') $destination -Force
Copy-Item (Join-Path $sourceFolder 'docs') $destination -Recurse
$sampleTest = Join-Path $destination 'test/widget_test.dart'
if (Test-Path $sampleTest) { Remove-Item $sampleTest }
$manifestPath = Join-Path $destination 'android/app/src/main/AndroidManifest.xml'
$manifest = [System.IO.File]::ReadAllText($manifestPath)
if (-not $manifest.Contains('android.permission.INTERNET')) {
  $manifest = $manifest.Replace('<application', '<uses-permission android:name="android.permission.INTERNET" />' + "`n    <application")
  [System.IO.File]::WriteAllText($manifestPath, $manifest)
}
Push-Location $destination
try {
  flutter pub get
  if ($LASTEXITCODE -ne 0) { throw 'flutter pub get gagal. Periksa internet/versi SDK.' }
  flutter analyze
  if ($LASTEXITCODE -ne 0) {
    Write-Warning 'Analyzer melaporkan temuan. Periksa output sebelum menjalankan aplikasi.'
  }
} finally { Pop-Location }
Write-Host "Selesai. Buka folder $destination di VS Code, lalu jalankan flutter run."
