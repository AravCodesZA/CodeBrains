import 'package:flutter/material.dart';
import 'signup_page.dart';

/// ---------- Color Palette ----------
class AppColors {
  static const darkNavy = Color(0xFF0B1222);      // Background start
  static const yankeesBlue = Color(0xFF1C2841);   // Background end
  static const cornflowerBlue = Color(0xFF6495ED); // Button start
  static const royalPurple = Color(0xFF7851A9);    // Button end
  static const white = Colors.white;               // Main text
  static const fadedWhite = Color.fromRGBO(255, 255, 255, 0.7); // Faded text
}

/// ---------- Login Page ----------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true; // Used to toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- Gradient background from dark navy to Yankees blue ---
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkNavy, AppColors.yankeesBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // --- Page content centered on screen ---
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Page heading ---
                  const Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to access your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.fadedWhite,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Email field ---
                  TextFormField(
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle:
                      const TextStyle(color: AppColors.fadedWhite),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Password field with toggle icon ---
                  TextFormField(
                    obscureText: _obscure,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                      const TextStyle(color: AppColors.fadedWhite),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.fadedWhite,
                        ),
                        onPressed: () =>
                            setState(() => _obscure = !_obscure),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Gradient button (cornflower → royal purple) ---
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.cornflowerBlue,
                          AppColors.royalPurple
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- Small footer link ---
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: AppColors.cornflowerBlue, // highlight color
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),






            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}