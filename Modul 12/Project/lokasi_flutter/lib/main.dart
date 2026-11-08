import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lokasi Saya',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: const Color(0xFFF4F5FA),
    ),
    home: const LocationScreen(),
  );
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _kecamatan;
  String? _kota;
  bool _isLoading = false;
  String? _errorMessage;
  Position? _position;
  bool _showLocationSettings = false;
  bool _showAppSettings = false;

  String _firstAvailable(List<String?> values) => values.firstWhere(
    (value) => value != null && value.trim().isNotEmpty,
    orElse: () => 'Tidak tersedia',
  )!;

  Future<void> _getLocation() async {
    if (_isLoading) return;
    // setState memperbarui kartu menjadi indikator proses.
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _kecamatan = null;
      _kota = null;
      _position = null;
      _showLocationSettings = false;
      _showAppSettings = false;
    });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showLocationSettings = true;
        throw Exception('Layanan lokasi tidak aktif. Mohon aktifkan GPS.');
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        _showAppSettings = true;
        throw Exception('Izin lokasi ditolak permanen. Aktifkan izin melalui pengaturan aplikasi.');
      }
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Izin lokasi belum diberikan. Izinkan akses lokasi lalu coba lagi.');
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );
      final places = await placemarkFromCoordinates(
        position.latitude, position.longitude,
      ).timeout(const Duration(seconds: 20));
      if (places.isEmpty) {
        throw Exception('Tidak dapat menemukan informasi alamat. Periksa koneksi internet dan coba lagi.');
      }
      if (!mounted) return;
      final place = places.first;
      setState(() {
        _position = position;
        _kecamatan = _firstAvailable([place.subLocality, place.locality]);
        _kota = _firstAvailable([place.subAdministrativeArea, place.administrativeArea]);
      });
    } on TimeoutException {
      if (!mounted) return;
      setState(() => _errorMessage = 'Waktu pencarian habis. Pastikan GPS dan internet aktif, lalu coba di tempat terbuka.');
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openSettings(bool appSettings) async {
    try {
      final opened = appSettings
          ? await Geolocator.openAppSettings()
          : await Geolocator.openLocationSettings();
      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Buka pengaturan perangkat secara manual.')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buka pengaturan perangkat secara manual.')),
      );
    }
  }

  Widget _locationContent() {
    if (_isLoading) {
      return const Column(children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Sedang mengambil lokasi...', textAlign: TextAlign.center),
      ]);
    }
    if (_errorMessage != null) {
      return Column(children: [
        const Icon(Icons.error_outline, size: 46, color: Colors.red),
        const SizedBox(height: 12),
        Text(_errorMessage!, textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red)),
        if (_showLocationSettings)
          TextButton(onPressed: () => _openSettings(false), child: const Text('BUKA PENGATURAN GPS')),
        if (_showAppSettings)
          TextButton(onPressed: () => _openSettings(true), child: const Text('BUKA PENGATURAN APLIKASI')),
      ]);
    }
    if (_kecamatan == null && _kota == null) {
      return const Column(children: [
        Icon(Icons.location_on_outlined, size: 64, color: Color(0xFF1A237E)),
        SizedBox(height: 16),
        Text('Tekan tombol untuk menampilkan lokasi.', textAlign: TextAlign.center),
      ]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Center(child: Icon(Icons.location_on, size: 52, color: Color(0xFF1A237E))),
      const SizedBox(height: 20),
      Text('Kelurahan/Kecamatan: $_kecamatan', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Text('Kota: $_kota', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      if (_position != null) ...[
        const Divider(height: 28),
        Text('Latitude: ${_position!.latitude.toStringAsFixed(6)}'),
        Text('Longitude: ${_position!.longitude.toStringAsFixed(6)}'),
      ],
    ]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Lokasi Saya', style: TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF1A237E)),
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Card(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: _locationContent())),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _isLoading ? null : _getLocation,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E),
              foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('TAMPILKAN LOKASI SAAT INI', textAlign: TextAlign.center)),
          const SizedBox(height: 16),
          const Text('Modul 12 • Akses Lokasi dengan GPS', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ])),
    ))),
  );
}
