import 'package:finance_tracker/widgets/custom_radio.dart';
import 'package:finance_tracker/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/widgets/custom_input.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEnabled = true;
  bool isLoading = false;

  void _handleLogin() async {
    setState(() => isLoading = true);

    final success = await context.read<AuthProvider>().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng nhập thất bại')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            // 🔽 SVG Illustration
            SvgPicture.asset(
              'assets/illustrations/proud-designer.svg',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 48),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please Sign In to continue',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            CustomInput(
              hintText: 'Email',
              controller: emailController,
              prefixIcon: const Icon(Icons.email, size: 20),
            ),
            const SizedBox(height: 16),
            CustomInput(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock, size: 20),
            ),
            // Reminder login
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 14,),
                Text("Reminder me nextime", style: TextStyle(fontSize: 12),),
                Spacer(),
                CustomSwitch(
                  value: isEnabled,
                  onChanged: (val) => setState(() => isEnabled = val),
                ),
              ],
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(text: 'Sign In', onPressed: _handleLogin),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    // 👉 Điều hướng sang màn hình đăng ký
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
