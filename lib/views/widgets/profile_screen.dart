import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newshive/views/widgets/change_password_screen.dart';
import 'package:newshive/views/widgets/edit_profile_screen.dart';
import 'package:newshive/views/widgets/login_screen.dart';

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
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(6.w),
                          child: const Icon(Icons.edit, size: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  _profileRow('Name', 'Cody Fisher'),
                  SizedBox(height: 8.h),
                  _profileRow('Gmail', 'CodyFisher@gmail.com'),
                  SizedBox(height: 8.h),
                  _profileRow('Number', '+7-445-557-681'),
                  SizedBox(height: 8.h),
                  _profileRow(
                    'Address',
                    'Ludgate Hill 1, Greater London, London, EC4M 7AA',
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

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
            const Divider(), // Pemisah
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
            const Divider(), // Pemisah
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
            // Divider(),
            // _menuItem(Icons.lock_outline, 'Change Password', () {}),

            // Divider(),
            // _menuItem(Icons.logout, 'Logout', () {}),
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

  // Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
  //   return ListTile(
  //     contentPadding: EdgeInsets.zero,
  //     leading: Icon(icon, color: Colors.black),
  //     title: Text(label, style: TextStyle(fontSize: 16.sp)),
  //     onTap: onTap,
  //   );
  // }
}
