import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:finance_tracker/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/widgets/custom_input.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/screens/auth/register_screen.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController emailController;
  late final TextEditingController telController;
  late final TextEditingController passwordController;
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
  void initState() {
    super.initState();
    emailController = TextEditingController();
    telController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    telController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              // 🔽 SVG Illustration
              SvgPicture.asset(
                'assets/illustrations/everywhere-together.svg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  s.auth_register,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  s.auth_register_subtitle,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              CustomInput(
                hintText: s.auth_mail,
                controller: emailController,
                prefixIcon: const Icon(LucideIcons.mail, size: 18),
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: s.auth_tel,
                controller: telController,
                prefixIcon: const Icon(LucideIcons.phone, size: 18),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: s.auth_password,
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(LucideIcons.lock, size: 18),
              ),
              // Reminder login
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 14),
                  Text(
                    s.auth_remenber_next_time_text,
                    style: TextStyle(fontSize: 12),
                  ),
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
                  : CustomButton(
                      text: s.auth_signup,
                      onPressed: _handleRegister,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.auth_already_have_account,
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
                    child: Text(
                      s.auth_signin,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
