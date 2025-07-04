import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNewsScreen extends StatelessWidget {
  const EditNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = TextEditingController(
      text: 'https://siagaindonesia.id/wp-content/uploads/2025/05/581638_06243412052025_dedi_mulyadi_1_rmoljab-750x375.jpeg',
    );
    final titleController = TextEditingController(
      text: 'KDM: Antara Iket Sunda, "Gubernur Konten", dan Realitas Kepemimpinan',
    );
    final categoryController = TextEditingController(
      text: 'Politics',
    );
    final contentController = TextEditingController(
      text:
          'Di panggung politik Jawa Barat, bahkan nasional, nama Kang Dedi Mulyadi (KDM) telah menjadi fenomena tersendiri. '
          'Sosoknya, yang kini menjabat Gubernur Jawa Barat, tak bisa dilepaskan dari citra kuat yang dibangunnya selama bertahun-tahun: '
          'perpaduan antara penampilan visual yang khas dengan narasi kepemimpinan yang merakyat dan berakar budaya. '
          'Namun, di balik popularitas yang meroket, terutama di era media sosial yang menjulukinya "Gubernur Konten", '
          'terbentang spektrum persepsi publik yang kompleks, dari puja-puji hingga kritik tajam. Menganalisis citra '
          'KDM melalui lensa visualisasi dan konseptualisasi menjadi penting untuk memahami bagaimana ia dipandang, dan '
          'apa implikasinya bagi lanskap politik kita.',
    );

    InputDecoration inputDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: Colors.black),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w), // spacing balance
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: imageController,
                      decoration: inputDecoration('URL Picture'),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: titleController,
                      decoration: inputDecoration('Title'),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: categoryController,
                      decoration: inputDecoration('Category'),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: contentController,
                      maxLines: 8,
                      decoration: inputDecoration('Description'),
                    ),
                    SizedBox(height: 100.h), // Extra space for keyboard
                  ],
                ),
              ),
            ),

            // Button
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {},
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