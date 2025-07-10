import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/services/news_service.dart';
import 'package:newshive/views/models/artikel.dart';
import 'package:newshive/views/widgets/add_news_screen.dart';
import 'package:newshive/views/widgets/edit_news_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<Artikel>> _artikelFuture;

  @override
  void initState() {
    super.initState();
    _artikelFuture = ArtikelService.fetchArtikel();
  }

  void _refreshList() {
    setState(() {
      _artikelFuture = ArtikelService.fetchArtikel();
    });
  }

  Future<void> _deleteArtikel(BuildContext context, String id) async {
    Navigator.pop(context);
    try {
      await ArtikelService.deleteArtikel(id);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Berita berhasil dihapus')));
      _refreshList();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal hapus: $e')));
    }
  }

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
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EEE8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'News List',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
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

                    final newsList = snapshot.data!;
                    return ListView.builder(
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsList[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child:
                                        news.imagePath.startsWith('http')
                                            ? Image.network(
                                              news.imagePath,
                                              width: 80.w,
                                              height: 80.w,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.asset(
                                              news.imagePath,
                                              width: 80.w,
                                              height: 80.w,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          news.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          news.date,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Action :',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => EditNewsScreen(
                                                    artikel: news,
                                                  ),
                                            ),
                                          ).then((_) => _refreshList());
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 16,
                                                      ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Icon(
                                                        Icons.error_outline,
                                                        size: 40,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      const Text(
                                                        'Are you sure you want to delete this news?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      30,
                                                                    ),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                    ),
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      30,
                                                                    ),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () =>
                                                                    _deleteArtikel(
                                                                      context,
                                                                      news.id,
                                                                    ),
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: 24.h,
          left: 20.w,
          right: 20.w,
          top: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: SizedBox(
          height: 56.h,
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddNewsScreen()),
              ).then((value) {
                if (value == true) {
                  _refreshList();
                }
              });
            },
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            label: const Text(
              'Add News',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
