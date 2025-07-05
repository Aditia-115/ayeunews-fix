import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/views/widgets/detail_screen.dart';
import '../models/artikel.dart';

class BookmarkScreen extends StatefulWidget {
  final List<Artikel> bookmarks;
  final void Function(Artikel) onBookmarkRemoved;

  const BookmarkScreen({
    super.key,
    required this.bookmarks,
    required this.onBookmarkRemoved,
  });

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String query = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Politic',
    'Sport',
    'Education',
    'Business',
    'Health',
    'Lifestyle',
    'Technology',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookmarks =
        widget.bookmarks.where((artikel) {
          final matchQuery = artikel.title.toLowerCase().contains(
            query.toLowerCase(),
          );
          final matchCategory =
              selectedCategory == 'All' || artikel.category == selectedCategory;
          return matchQuery && matchCategory;
        }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Image.asset('assets/images/logo.png', height: 32.h),
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

              // 🔍 Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEE8),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => query = val),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.tune, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // 🧭 Categories
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (_, index) {
                    final cat = categories[index];
                    final isSelected = cat == selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue
                                  : const Color(0xFFF0EEE8),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // 📚 Bookmark List
              if (filteredBookmarks.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No bookmark found.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredBookmarks.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final artikel = filteredBookmarks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => DetailScreen(
                                    title: artikel.title,
                                    author: artikel.author,
                                    date: artikel.date,
                                    category: artikel.category,
                                    content: artikel.content,
                                    imagePath: artikel.imagePath,
                                    isBookmarked: widget.bookmarks.contains(
                                      artikel,
                                    ),
                                    onBookmarkToggle:
                                        () => widget.onBookmarkRemoved(artikel),
                                  ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                artikel.imagePath,
                                width: 90.w,
                                height: 90.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 90.w,
                                    height: 90.w,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image),
                                  );
                                },
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
                              onPressed:
                                  () => widget.onBookmarkRemoved(artikel),
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
