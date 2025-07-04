import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNewsScreen extends StatefulWidget {
  const EditNewsScreen({super.key});

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _descController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EEE8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Edit News',
                        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w), // Spacer
                ],
              ),
            ),

            // Form fields + button
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      TextFormField(controller: _urlController, decoration: _inputDecoration('URL Picture')),
                      SizedBox(height: 16.h),
                      TextFormField(controller: _titleController, decoration: _inputDecoration('Title')),
                      SizedBox(height: 16.h),
                      TextFormField(controller: _categoryController, decoration: _inputDecoration('Category')),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _descController,
                        decoration: _inputDecoration('Description'),
                        maxLines: 6,
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        color: Colors.white,
        child: SizedBox(
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            child: Text(
              'Update News',
              style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}