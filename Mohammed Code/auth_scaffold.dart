import 'package:flutter/material.dart';
import 'app_theme.dart';

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
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [AppColors.logoPurple, AppColors.logoBlue],
              ),
            ),
            alignment: Alignment.center,
            child: const Text('AI', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          const Text('CODEBRAINS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
        gradient: LinearGradient(colors: [AppColors.cardTop, AppColors.cardBottom]),
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
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle!, style: const TextStyle(color: AppColors.subtext, fontSize: 15)),
        ]
      ],
    );
  }
}
