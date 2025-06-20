import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String category;
  final String content;
  final String imagePath;

  const DetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.category,
    required this.content,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EEE8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EEE8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Banner image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),

            // Content section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Author and metadata
                      Text(
                        'Oleh; $author',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        date,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        category,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        content,
                        style: TextStyle(fontSize: 14.sp, height: 1.6),
                      ),
                    ],
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