import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newshive/routes/route_names.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.h),
            Image.asset(
              'assets/images/register_illustration.jpg', // Ganti sesuai file kamu
              height: 300.h,
            ),
            SizedBox(height: 20.h),
            const _InputField(icon: Icons.person_outline, hintText: 'Name'),
            SizedBox(height: 20.h),
            const _InputField(icon: Icons.email_outlined, hintText: 'Email'),
            SizedBox(height: 20.h),
            const _InputField(
              icon: Icons.phone_outlined,
              hintText: 'Phone Number',
            ),
            SizedBox(height: 20.h),
            const _InputField(
              icon: Icons.lock_outline,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteNames.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              context.goNamed(RouteNames.login);
                            },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;

  const _InputField({
    required this.icon,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
