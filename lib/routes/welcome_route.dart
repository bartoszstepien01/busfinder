import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _DeepArcClipper extends CustomClipper<Path> {
  final bool horizontal;

  const _DeepArcClipper({this.horizontal = false});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (!horizontal) {
      path.lineTo(0, size.height - 100);

      path.quadraticBezierTo(
        size.width / 2,
        size.height + 40,
        size.width,
        size.height - 100,
      );

      path.lineTo(size.width, 0);
    } else {
      path.lineTo(size.width - 100, 0);

      path.quadraticBezierTo(
        size.width + 40,
        size.height / 2,
        size.width - 100,
        size.height,
      );

      path.lineTo(0, size.height);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _DeepArcClipper oldClipper) =>
      oldClipper.horizontal != horizontal;
}

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1000) {
            return Column(
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
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipPath(
                    clipper: _DeepArcClipper(horizontal: true),
                    child: Image.asset(
                      'assets/background.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 60),
                        FilledButton(
                          onPressed: () => context.push('/login'),
                          child: Text(localizations.login),
                        ),
                        SizedBox(height: 5),
                        OutlinedButton(
                          onPressed: () => context.push('/signup'),
                          child: Text(localizations.singup),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
