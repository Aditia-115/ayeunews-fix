import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/services/news_service.dart';
import 'package:newshive/views/models/artikel.dart';

class EditNewsScreen extends StatefulWidget {
  final Artikel artikel;

  const EditNewsScreen({super.key, required this.artikel});

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _imageController;
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController(text: widget.artikel.imagePath);
    _titleController = TextEditingController(text: widget.artikel.title);
    _categoryController = TextEditingController(text: widget.artikel.category);
    _contentController = TextEditingController(text: widget.artikel.content);
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitEdit() async {
    if (_formKey.currentState!.validate()) {
      final success = await ArtikelService.updateNews(
        id: widget.artikel.id,
        title: _titleController.text.trim(),
        category: _categoryController.text.trim(),
        content: _contentController.text.trim(),
        imageUrl: _imageController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berita berhasil diperbarui')),
        );
        Navigator.pop(context, true); // kembalikan status
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui berita')),
        );
      }
    }
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0EEE8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Edit News',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _imageController,
                        decoration: inputDecoration('URL Picture'),
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Harus diisi' : null,
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _titleController,
                        decoration: inputDecoration('Title'),
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Harus diisi' : null,
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _categoryController,
                        decoration: inputDecoration('Category'),
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Harus diisi' : null,
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _contentController,
                        maxLines: 8,
                        decoration: inputDecoration('Description'),
                        validator:
                            (v) =>
                                v == null || v.isEmpty ? 'Harus diisi' : null,
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _submitEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Update News',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
