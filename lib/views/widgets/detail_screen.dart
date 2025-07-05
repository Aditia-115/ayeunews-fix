import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String author;
  final String date;
  final String category;
  final String content;
  final String imagePath;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const DetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.category,
    required this.content,
    required this.imagePath,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  void _handleBookmarkToggle() {
    widget.onBookmarkToggle();
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

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
                      icon: Icon(
                        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      ),
                      onPressed: _handleBookmarkToggle,
                    ),
                  ),
                ],
              ),
            ),

            // Banner image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                widget.imagePath,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 180.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
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
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Oleh: ${widget.author}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.category,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        widget.content,
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
