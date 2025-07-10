import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newshive/views/models/artikel.dart';

class ArtikelService {
  static const String _baseUrl = 'http://45.149.187.204:3000';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Ambil semua artikel dari API (Read)
  static Future<List<Artikel>> fetchArtikel() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/api/news'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body['body']['data'];
      return data.map((json) => Artikel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil artikel');
    }
  }

  /// Tambah artikel baru ke API (Create)
  static Future<bool> addNews({
    required String title,
    required String category,
    required String content,
    required String imageUrl,
  }) async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/api/author/news');

    final body = {
      'title': title,
      'summary': content,
      'content': content,
      'featuredImageUrl': imageUrl,
      'category': category,
      'tags': ['berita'],
      'isPublished': true,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('POST body: $body');
    print('Response: ${response.statusCode} → ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      return decoded['body']?['success'] == true;
    }

    return false;
  }

  /// Perbarui (Edit) artikel berdasarkan ID (Update)
  static Future<bool> updateNews({
    required String id,
    required String title,
    required String category,
    required String content,
    required String imageUrl,
  }) async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/api/author/news/$id');

    final body = {
      'title': title,
      'summary': content,
      'content': content,
      'featuredImageUrl': imageUrl,
      'category': category,
      'tags': ['berita'],
      'isPublished': true,
    };

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('PUT body: $body');
    print('Response: ${response.statusCode} → ${response.body}');

    return response.statusCode == 200;
  }

  /// Hapus artikel berdasarkan ID (Delete)
  static Future<void> deleteArtikel(String id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/api/author/news/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus artikel');
    }
  }
}
