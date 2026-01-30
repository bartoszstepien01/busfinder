import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  const ResponsiveContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 1000 : double.infinity,
        ),
        child: child,
      ),
    );
  }
}
