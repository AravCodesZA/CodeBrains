import 'package:flutter/material.dart';

/// ---------- Color Palette ----------
class AppColors {
  static const darkNavy = Color(0xFF0B1222);
  static const yankeesBlue = Color(0xFF1C2841);
  static const cornflowerBlue = Color(0xFF6495ED);
  static const royalPurple = Color(0xFF7851A9);
  static const white = Colors.white;
  static const fadedWhite = Color.fromRGBO(255, 255, 255, 0.7);
}

/// ---------- Sign-Up Page ----------
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- Gradient background ---
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkNavy, AppColors.yankeesBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // --- Centered content layout ---
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Title and subtitle ---
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign up to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.fadedWhite,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Full name field ---
                  TextFormField(
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: "Full name",
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

                  // --- Password field with toggle ---
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

                  // --- Gradient Sign-Up button ---
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
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- Footer link ---
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have an account? Sign in",
                    style: TextStyle(
                      color: AppColors.cornflowerBlue,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}