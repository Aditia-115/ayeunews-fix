import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/views/widgets/detail_screen.dart';
import '../models/artikel.dart';

class HomeScreen extends StatelessWidget {
  final List<Artikel> bookmarkedArticles;
  final void Function(Artikel) onBookmarkToggled;

  const HomeScreen({
    super.key,
    required this.bookmarkedArticles,
    required this.onBookmarkToggled,
  });

  @override
  Widget build(BuildContext context) {
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

    final List<String> carouselImages = List.generate(
      3,
      (_) => 'assets/images/hostpur.jpg',
    );

    final demoArticles = [
      Artikel(
        id: '001',
        title:
            'KDM: Antara Iket Sunda, "Gubernur Konten", dan Realitas Kepemimpinan',
        author: 'Aziz Muslim Haruna',
        date: '23 Mei 2025 13:03',
        category: 'Politics',
        content:
            'Di panggung politik Jawa Barat, bahkan nasional, nama Kang Dedi Mulyadi (KDM) telah menjadi fenomena tersendiri. '
            'Sosoknya, yang kini menjabat Gubernur Jawa Barat, tak bisa dilepaskan dari citra kuat yang dibangunnya selama bertahun-tahun: '
            'perpaduan antara penampilan visual yang khas dengan narasi kepemimpinan yang merakyat dan berakar budaya. '
            'Namun, di balik popularitas yang meroket, terutama di era media sosial yang menjulukinya "Gubernur Konten", '
            'terbentang spektrum persepsi publik yang kompleks, dari puja-puji hingga kritik tajam. '
            'Menganalisis citra KDM melalui lensa visualisasi dan konseptualisasi menjadi penting untuk memahami bagaimana ia dipandang, '
            'dan apa implikasinya bagi lanskap politik kita.',
        imagePath: 'assets/images/kdm.jpg',
      ),
    ];
    final List<Artikel> articles = demoArticles;

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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  _buildSearchBar(),
                  SizedBox(height: 20.h),
                  CarouselSlider.builder(
                    itemCount: carouselImages.length,
                    itemBuilder: (context, index, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.asset(
                          carouselImages[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeader(categories: categories),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: SliverList.separated(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                final isBookmarked = bookmarkedArticles.contains(article);
                return _buildNewsItem(context, article, isBookmarked);
              },
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
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
            child: Text(
              'Search',
              style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
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
            builder: (_) => DetailScreen(
              title: artikel.title,
              author: artikel.author,
              date: artikel.date,
              category: artikel.category,
              content: artikel.content,
              imagePath: artikel.imagePath,
              isBookmarked: bookmarkedArticles.contains(artikel),
              onBookmarkToggle: () => onBookmarkToggled(artikel),
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
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => onBookmarkToggled(artikel),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  _CategoryHeader({required this.categories});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 40.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 8.w),
          itemBuilder: (context, index) {
            final isSelected = index == 0;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : const Color(0xFFF0EEE8),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.h;
  @override
  double get minExtent => 60.h;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
