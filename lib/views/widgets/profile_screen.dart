import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/routes/route_names.dart';
import 'package:newshive/services/auth_service.dart';
import 'package:newshive/views/widgets/change_password_screen.dart';
import 'package:newshive/views/widgets/edit_profile_screen.dart';
import 'package:newshive/views/widgets/login_screen.dart';
import 'package:newshive/views/widgets/news_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24.h),

            // Profile Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const AssetImage(
                          'assets/images/avatar.png',
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 4,
                        child: Container(padding: EdgeInsets.all(6.w)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  _profileRow('Name', 'ITG News'),
                  SizedBox(height: 8.h),
                  _profileRow('Gmail', 'news@itg.ac.id'),
                  SizedBox(height: 8.h),
                  _profileRow('Number', '+62 852-2288-4009'),
                  SizedBox(height: 8.h),
                  _profileRow(
                    'Address',
                    'Jl. Mayor Syamsu No. 1, Jayaraga, Kec. Tarogong Kidul, Garut 44151',
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Add News Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewsListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'News List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Menu
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Future.microtask(() async {
                  await AuthService.logout();

                  if (!context.mounted) return;
                  context.goNamed(RouteNames.login);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        Expanded(child: Text(value, style: TextStyle(fontSize: 14.sp))),
      ],
    );
  }
}
