import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/views/widgets/detail_screen.dart';
import '../models/artikel.dart';

class BookmarkScreen extends StatelessWidget {
  final List<Artikel> bookmarks;
  final void Function(Artikel) onBookmarkRemoved;

  const BookmarkScreen({
    super.key,
    required this.bookmarks,
    required this.onBookmarkRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Image.asset(
                'assets/images/logo.png',
                height: 32.h,
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  'Bookmark',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              if (bookmarks.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No bookmark yet.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: bookmarks.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final artikel = bookmarks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                title: artikel.title,
                                author: artikel.author,
                                date: artikel.date,
                                category: artikel.category,
                                content: artikel.content,
                                imagePath: artikel.imagePath,
                                isBookmarked: bookmarks.contains(artikel),
                                onBookmarkToggle: () => onBookmarkRemoved(artikel),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(
                                artikel.imagePath,
                                width: 90.w,
                                height: 90.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikel.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    artikel.date,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => onBookmarkRemoved(artikel),
                              icon: const Icon(Icons.bookmark),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}