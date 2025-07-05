import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/services/news_service.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;

  final List<String> categories = [
    'Business',
    'Crime',
    'Education',
    'Entertainment',
    'Health',
    'Lifestyle',
    'Politic',
    'Science',
    'Sport',
    'Technology',
    'Travel',
  ];

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath == true &&
        (url.startsWith('http://') || url.startsWith('https://'));
  }

  Future<void> _submitNews() async {
    if (_formKey.currentState!.validate()) {
      final success = await ArtikelService.addNews(
        title: _titleController.text.trim(),
        category: _selectedCategory!,
        content: _descriptionController.text.trim(),
        imageUrl: _imageController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Berita berhasil dipublish' : 'Gagal mempublish berita',
          ),
        ),
      );

      if (success) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                        'Add News',
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

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _imageController,
                        hintText: 'URL Picture',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'URL gambar wajib diisi';
                          }
                          if (!_isValidUrl(value.trim())) {
                            return 'Masukkan URL gambar yang valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.h),

                      _buildTextField(
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                      SizedBox(height: 12.h),

                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        decoration: InputDecoration(
                          hintText: 'Select Category',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        items:
                            categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                        onChanged:
                            (val) => setState(() => _selectedCategory = val),
                        validator:
                            (val) => val == null ? 'Pilih kategori' : null,
                      ),
                      SizedBox(height: 12.h),

                      _buildTextField(
                        controller: _descriptionController,
                        hintText: 'Description',
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            Container(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: const Color.fromRGBO(158, 158, 158, 0.2),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _submitNews,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Publish News',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
      validator:
          validator ??
          (value) =>
              value == null || value.trim().isEmpty
                  ? 'Field wajib diisi'
                  : null,
    );
  }
}
