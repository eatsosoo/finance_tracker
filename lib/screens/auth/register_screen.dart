import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:finance_tracker/widgets/custom_radio.dart';
import 'package:finance_tracker/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/widgets/custom_input.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/screens/auth/register_screen.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEnabled = true;
  bool isLoading = false;

  void _handleRegister() async {
    setState(() => isLoading = true);

    final success = await context.read<AuthProvider>().register(
      emailController.text.trim(),
      passwordController.text.trim(),
      telController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, '/dashboard');
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
            const SizedBox(height: 40),
            // 🔽 SVG Illustration
            SvgPicture.asset(
              'assets/illustrations/everywhere-together.svg',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please Sign Up to continue',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            CustomInput(
              hintText: 'Email',
              controller: emailController,
              prefixIcon: const Icon(Iconsax.sms, size: 20),
            ),
            const SizedBox(height: 12),
            CustomInput(
              hintText: 'Tel',
              controller: telController,
              prefixIcon: const Icon(Iconsax.call, size: 20),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 12),
            CustomInput(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
              prefixIcon: const Icon(Iconsax.lock, size: 20),
            ),
            // Reminder login
            const SizedBox(height: 12),
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
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(text: 'Sign Up', onPressed: _handleRegister),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have account?",
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    // 👉 Điều hướng sang màn hình đăng ký
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign In',
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
