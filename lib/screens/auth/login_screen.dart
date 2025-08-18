import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isEnabled = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => isLoading = true);

    final success = await context.read<AuthProvider>().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context)!.auth_login_failed)));
    }
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
              // SVG Illustration
              SvgPicture.asset(
                'assets/illustrations/proud-designer.svg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(s.auth_login, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(s.auth_login_subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              CustomInput(
                hintText: s.auth_mail,
                controller: emailController,
                prefixIcon: const Icon(LucideIcons.mail, size: 18),
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: s.auth_password,
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(LucideIcons.lock, size: 18),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 14),
                  Text(s.auth_remenber_next_time_text, style: const TextStyle(fontSize: 12)),
                  const Spacer(),
                  CustomSwitch(
                    value: isEnabled,
                    onChanged: (val) => setState(() => isEnabled = val),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(text: s.auth_signin, onPressed: _handleLogin),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(s.auth_not_have_account, style: const TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(s.auth_signup, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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