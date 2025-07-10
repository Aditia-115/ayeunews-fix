import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newshive/routes/route_names.dart';
import 'package:newshive/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username dan password harus diisi')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService.login(username, password);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['body']['data']['token'];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          context.goNamed(RouteNames.main);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Token tidak ditemukan')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            Image.asset('assets/images/login_illustration.jpg', height: 300.h),
            SizedBox(height: 20.h),
            _InputField(
              controller: _usernameController,
              icon: Icons.person_outline,
              hintText: 'Username',
            ),
            SizedBox(height: 20.h),
            _InputField(
              controller: _passwordController,
              icon: Icons.lock_outline,
              hintText: 'Password',
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.goNamed(RouteNames.forgotPassword);
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 130.h),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Login',
                        style:
                            TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Haven't any account? ",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed(RouteNames.register);
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

class _InputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const _InputField({
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
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