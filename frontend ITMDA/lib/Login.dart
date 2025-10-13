import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'signup_page.dart';
import 'main.dart';

void main() => runApp(const MyApp());

/* ------------------------------ Theming ------------------------------ */
ThemeData buildDarkTheme() {
  final cs = const ColorScheme.dark(
    surface: AppColors.navyBg,
    primary: AppColors.violet,
    secondary: AppColors.lightBlue,
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: AppColors.navyBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.navyBg,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      labelStyle: const TextStyle(color: AppColors.subtext),
      hintStyle: const TextStyle(color: AppColors.subtext),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightBlue, width: 1.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.secondary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: cs.secondary),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.subtext),
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );
}

/* ------------------------------- App --------------------------------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CODEBRAINS Auth',
      debugShowCheckedModeBanner: false,
      theme: buildDarkTheme(),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        '/home': (_) =>  WelcomeScreen(),
      },
    );
  }
}

/* ---------------------- Shared auth page scaffold --------------------- */
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _brandAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Header(title: title, subtitle: subtitle),
                const SizedBox(height: 20),
                _GradientCard(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _brandAppBar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.logoPurple, AppColors.logoBlue],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'AI',
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text('CODEBRAINS',
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1,
              )),
        ],
      ),
    );
  }
}

class _GradientCard extends StatelessWidget {
  const _GradientCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.cardTop, AppColors.cardBottom],
        ),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      padding: const EdgeInsets.all(18),
      child: child,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.violet, fontSize: 28, fontWeight: FontWeight.w700,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.subtext, fontSize: 13),
          ),
        ]
      ],
    );
  }
}

/* ------------------------------- Login -------------------------------- */
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.signIn(_email.text.trim(), _password.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to continue to your profile.',
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.username, AutofillHints.email],
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Enter a valid email';
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Sign in'),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/signup'),
                child: const Text("Don't have an account? Create one"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------ Sign Up ------------------------------- */
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.signUp(_name.text.trim(), _email.text.trim(), _password.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create account',
      subtitle: 'Sign up to access the admin tools.',
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (v) => (v == null || v.trim().length < 2) ? 'Enter your name' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Enter a valid email';
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              autofillHints: const [AutofillHints.newPassword],
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _confirm,
              obscureText: _obscure,
              decoration: const InputDecoration(labelText: 'Confirm password'),
              validator: (v) => (v != _password.text) ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Create account'),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                child: const Text("Already have an account? Sign in"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------------- Home --------------------------------- */
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: const Center(
        child: Text(
          'Signed in! Replace this with your real dashboard.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

/* --------------------------- Dummy Auth API --------------------------- */
class AuthService {
  static Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.isEmpty || password.isEmpty) {
      throw 'Please enter email and password';
    }
  }

  static Future<void> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw 'Please fill in all fields';
    }
  }
}
