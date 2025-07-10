import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/views/widgets/detail_screen.dart';
import 'package:newshive/services/news_service.dart';
import '../models/artikel.dart';

class HomeScreen extends StatefulWidget {
  final List<Artikel> bookmarkedArticles;
  final void Function(Artikel) onBookmarkToggled;

  const HomeScreen({
    super.key,
    required this.bookmarkedArticles,
    required this.onBookmarkToggled,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void refreshArtikel() {
    setState(() {
      _artikelFuture = ArtikelService.fetchArtikel();
    });
  }

  late Future<List<Artikel>> _artikelFuture;
  String query = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
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
  void initState() {
    super.initState();
    _artikelFuture = ArtikelService.fetchArtikel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 60.h,
            title: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Image.asset('assets/images/logo.png', height: 32.h),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black),
                onPressed: refreshArtikel,
              ),
              SizedBox(width: 8.w),
            ],
          ),

          // Search & Carousel from Artikel
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  _buildSearchBar(),
                  SizedBox(height: 20.h),
                  FutureBuilder<List<Artikel>>(
                    future: _artikelFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      final carouselArticles = snapshot.data!.take(5).toList();
                      return CarouselSlider.builder(
                        itemCount: carouselArticles.length,
                        itemBuilder: (context, index, _) {
                          final artikel = carouselArticles[index];
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
                                        isBookmarked: widget.bookmarkedArticles
                                            .contains(artikel),
                                        onBookmarkToggle:
                                            () => widget.onBookmarkToggled(
                                              artikel,
                                            ),
                                      ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                artikel.imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 180.h,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayCurve: Curves.easeInOut,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
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
            ),
          ),

          // News List
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: FutureBuilder<List<Artikel>>(
                future: _artikelFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Tidak ada berita'));
                  }

                  final allArticles = snapshot.data!;
                  final filteredArticles =
                      allArticles.where((artikel) {
                        final matchQuery = artikel.title.toLowerCase().contains(
                          query.toLowerCase(),
                        );
                        final matchCategory =
                            selectedCategory == 'All' ||
                            artikel.category == selectedCategory;
                        return matchQuery && matchCategory;
                      }).toList();

                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredArticles.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final artikel = filteredArticles[index];
                      final isBookmarked = widget.bookmarkedArticles.contains(
                        artikel,
                      );
                      return _buildNewsItem(context, artikel, isBookmarked);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
                hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
              ),
            ),
          ),
          const Icon(Icons.tune, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildNewsItem(
    BuildContext context,
    Artikel artikel,
    bool isBookmarked,
  ) {
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
                  isBookmarked: isBookmarked,
                  onBookmarkToggle: () => widget.onBookmarkToggled(artikel),
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
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => widget.onBookmarkToggled(artikel),
          ),
        ],
      ),
    );
  }
}
