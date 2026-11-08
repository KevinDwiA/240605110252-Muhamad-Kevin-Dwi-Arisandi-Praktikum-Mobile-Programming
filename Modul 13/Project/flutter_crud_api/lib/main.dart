import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Model data respons JSON. API tidak menyediakan tanggal pembuatan;
// createdAt adalah waktu data diterima aplikasi.
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final DateTime createdAt;

  const Post({required this.id, required this.userId, required this.title,
    required this.body, required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: (json['id'] as num).toInt(),
    userId: (json['userId'] as num?)?.toInt() ?? 1,
    title: json['title'] as String,
    body: json['body'] as String,
    createdAt: DateTime.now(),
  );
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter CRUD Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo[900],
      scaffoldBackgroundColor: Colors.blueGrey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo[900],
        elevation: 4,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const _headers = {'Content-type': 'application/json; charset=UTF-8'};
  final http.Client _client = http.Client();
  Post? createdPost;
  bool _isLoading = false;

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  void _notify(String message, {bool success = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red));
  }

  // Seluruh request diberi timeout, penanganan error, dan pemeriksaan mounted.
  Future<void> _runOperation(Future<void> Function() operation) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      await operation();
    } on TimeoutException {
      _notify('Waktu permintaan habis. Periksa internet lalu coba lagi.');
    } on http.ClientException {
      _notify('Tidak dapat terhubung ke server. Periksa koneksi internet.');
    } on FormatException {
      _notify('Respons server tidak dapat dibaca. Silakan coba lagi.');
    } catch (error) {
      _notify('Operasi gagal: ${error.toString().replaceFirst('Exception: ', '')}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // CREATE: POST /posts, respons sukses 201.
  Future<void> createPost(String title, String body) => _runOperation(() async {
    final response = await _client.post(Uri.parse(_baseUrl),
      headers: _headers,
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    ).timeout(const Duration(seconds: 25));
    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan post (HTTP ${response.statusCode}).');
    }
    final post = Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    if (!mounted) return;
    setState(() => createdPost = post);
    _notify('Post berhasil ditambahkan!', success: true);
  });

  // UPDATE: sesuai modul selalu memakai ID 1. ID hasil POST (101)
  // tidak benar-benar disimpan oleh JSONPlaceholder dan tidak bisa di-PUT.
  Future<void> updatePost(int id, String title, String body) => _runOperation(() async {
    final original = createdPost;
    if (original == null || original.id != id) return;
    const demoId = 1;
    final response = await _client.put(Uri.parse('$_baseUrl/$demoId'),
      headers: _headers,
      body: jsonEncode({'id': demoId, 'title': title, 'body': body, 'userId': 1}),
    ).timeout(const Duration(seconds: 25));
    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate post (HTTP ${response.statusCode}).');
    }
    final post = Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    if (!mounted) return;
    setState(() => createdPost = Post(id: post.id, userId: post.userId,
      title: post.title, body: post.body, createdAt: original.createdAt));
    _notify('Post berhasil diupdate!', success: true);
  });

  // DELETE: setelah respons sukses, state null mengembalikan UI ke awal.
  Future<void> deletePost(int id) => _runOperation(() async {
    final response = await _client.delete(Uri.parse('$_baseUrl/$id'),
      headers: _headers).timeout(const Duration(seconds: 25));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Gagal menghapus post (HTTP ${response.statusCode}).');
    }
    if (!mounted) return;
    setState(() => createdPost = null);
    _notify('Post berhasil dihapus!', success: true);
  });

  Future<void> showAddPostDialog() async {
    final input = await showDialog<PostInput>(context: context,
      builder: (_) => const PostEditorDialog());
    if (!mounted || input == null) return;
    await createPost(input.title, input.body);
  }

  Future<void> showUpdatePostDialog(Post currentPost) async {
    final input = await showDialog<PostInput>(context: context,
      builder: (_) => PostEditorDialog(post: currentPost));
    if (!mounted || input == null) return;
    await updatePost(currentPost.id, input.title, input.body);
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
    final confirmed = await showDialog<bool>(context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus post ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red,
              foregroundColor: Colors.white), child: const Text('Hapus')),
        ],
      ));
    if (!mounted || confirmed != true) return;
    await deletePost(id);
  }

  Widget _postCard(Post post) => Card(
    elevation: 8,
    shadowColor: const Color(0x4D1A237E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(post.title, style: GoogleFonts.montserrat(
            fontSize: 26, fontWeight: FontWeight.w700, color: Colors.indigo[900]))),
          PopupMenuButton<String>(
            enabled: !_isLoading,
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'update', child: Text('Update')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
            onSelected: (value) {
              if (value == 'update') showUpdatePostDialog(post);
              if (value == 'delete') showDeleteConfirmationDialog(post.id);
            },
          ),
        ]),
        const SizedBox(height: 12),
        Text(post.body, style: GoogleFonts.openSans(fontSize: 18,
          height: 1.5, color: Colors.blueGrey[900])),
        const SizedBox(height: 12),
        Text('id: ${post.id}', style: GoogleFonts.openSans(fontSize: 14,
          color: Colors.blueGrey[600])),
        const SizedBox(height: 12),
        Text('userID: ${post.userId}', style: GoogleFonts.openSans(fontSize: 14,
          color: Colors.blueGrey[600])),
        const SizedBox(height: 16),
        // Konversi UTC+7 eksplisit agar label WIB benar pada semua perangkat.
        Text(DateFormat("dd MMMM yyyy, HH:mm 'WIB'").format(
          post.createdAt.toUtc().add(const Duration(hours: 7))),
          style: GoogleFonts.openSans(fontSize: 14,
            color: Colors.blueGrey[600], fontStyle: FontStyle.italic)),
      ])),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Demo CRUD client-server')),
    body: SafeArea(child: Column(children: [
      if (_isLoading) const LinearProgressIndicator(),
      Expanded(child: createdPost == null
        ? Center(child: Padding(padding: const EdgeInsets.all(24),
            child: Text('Demo CRUD client-server di Flutter', textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 18,
                fontWeight: FontWeight.w500, color: Colors.indigo[900]))))
        : ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [_postCard(createdPost!)])),
    ])),
    floatingActionButton: FloatingActionButton(
      onPressed: _isLoading ? null : showAddPostDialog,
      backgroundColor: Colors.indigo[900],
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add, size: 28)),
  );
}

class PostInput {
  final String title;
  final String body;
  const PostInput(this.title, this.body);
}

// Dialog memiliki lifecycle controller sendiri agar dibuang setelah animasi tutup.
class PostEditorDialog extends StatefulWidget {
  final Post? post;
  const PostEditorDialog({super.key, this.post});
  @override
  State<PostEditorDialog> createState() => _PostEditorDialogState();
}

class _PostEditorDialogState extends State<PostEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }
  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
  String? _required(String? value) => value == null || value.trim().isEmpty
      ? 'Bagian ini harus diisi' : null;
  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, PostInput(_titleController.text.trim(), _bodyController.text.trim()));
  }
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.post == null ? 'Tambah Post' : 'Update Post'),
    content: SingleChildScrollView(child: Form(key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(controller: _titleController, autofocus: true,
          decoration: const InputDecoration(labelText: 'Nama'),
          textInputAction: TextInputAction.next, validator: _required),
        TextFormField(controller: _bodyController,
          decoration: const InputDecoration(labelText: 'Pekerjaan'),
          textInputAction: TextInputAction.done, validator: _required,
          onFieldSubmitted: (_) => _save()),
      ]))),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
      ElevatedButton(onPressed: _save,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[900],
          foregroundColor: Colors.white),
        child: Text(widget.post == null ? 'Simpan' : 'Update')),
    ],
  );
}
