import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}

// Semua resep berasal dari HTTP API, tanpa fallback JSON lokal.
class MealApi {
  Future<Map<String, dynamic>> _get(String endpoint,
      [Map<String, String> params = const {}]) async {
    final uri = Uri.https('www.themealdb.com', '/api/json/v1/1/$endpoint', params);
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 20));
      if (response.statusCode != 200) {
        throw ApiException('Server mengembalikan HTTP ${response.statusCode}. Coba lagi.');
      }
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } on TimeoutException {
      throw const ApiException('Waktu koneksi habis. Periksa internet dan coba lagi.');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Resep gagal dimuat. Periksa koneksi internet atau coba lagi nanti.');
    }
  }
  List<Meal> _meals(Map<String, dynamic> json) =>
    (json['meals'] as List<dynamic>? ?? []).map((item) =>
      Meal.fromJson(item as Map<String, dynamic>)).toList();

  Future<List<Meal>> search(String query) async =>
    _meals(await _get('search.php', {'s': query}));
  Future<List<MealCategory>> categories() async {
    final json = await _get('categories.php');
    return (json['categories'] as List<dynamic>? ?? []).map((item) =>
      MealCategory.fromJson(item as Map<String, dynamic>)).toList();
  }
  Future<List<Meal>> byCategory(String name) async =>
    _meals(await _get('filter.php', {'c': name}));
  Future<Meal> detail(String id) async {
    final meals = _meals(await _get('lookup.php', {'i': id}));
    if (meals.isEmpty) throw const ApiException('Resep tidak ditemukan.');
    return meals.first;
  }
}
