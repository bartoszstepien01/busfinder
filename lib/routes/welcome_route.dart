import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _DeepArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40,
      size.width,
      size.height - 100,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: _DeepArcClipper(),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/background.jpg'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Text(
                    localizations.welcome,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    localizations.personalTravelAssistant,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => context.push('/login'),
                    child: Text(localizations.login),
                  ),
                  SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: () => context.push('/signup'),
                    child: Text(localizations.singup),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}