import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newshive/views/models/artikel.dart';

class ArtikelService {
  static const String _baseUrl = 'http://45.149.187.204:3000';

  /// Ambil semua artikel dari API (Read)
  static Future<List<Artikel>> fetchArtikel() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/news'));

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
    final url = Uri.parse('$_baseUrl/api/news');

    final payload = {
      'title': title,
      'category': category,
      'content': content,
      'featured_image_url': imageUrl,
    };

    print('🔼 Mengirim berita baru: ${jsonEncode(payload)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('✅ Status addNews: ${response.statusCode}');
    print('✅ Body response: ${response.body}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  /// Perbarui (Edit) artikel berdasarkan ID (Update)
  static Future<bool> updateNews({
    required int id,
    required String title,
    required String category,
    required String content,
    required String imageUrl,
  }) async {
    final url = Uri.parse('$_baseUrl/api/news/$id');

    final payload = {
      'title': title,
      'category': category,
      'content': content,
      'featured_image_url': imageUrl,
    };

    print('✏️ Mengupdate berita ID $id: ${jsonEncode(payload)}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('✅ Status update: ${response.statusCode}');
    print('✅ Body response: ${response.body}');

    return response.statusCode == 200;
  }

  /// Hapus artikel berdasarkan ID (Delete)
  static Future<void> deleteArtikel(String id) async {
    final url = Uri.parse('$_baseUrl/api/news/$id');

    print('🗑️ Menghapus artikel ID: $id');

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      print('❌ Gagal menghapus: ${response.statusCode}');
      throw Exception('Gagal menghapus artikel');
    } else {
      print('✅ Artikel berhasil dihapus');
    }
  }
}
