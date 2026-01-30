import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class BusRouteEntry extends StatelessWidget {
  final BusRouteResponseShortDto route;
  final String? subtitle;
  final VoidCallback? onTap;

  const BusRouteEntry({
    super.key,
    required this.route,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 2,
      shadowColor: colors.shadow.withAlpha(26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: colors.primary.withAlpha(26),
        highlightColor: colors.primary.withAlpha(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_bus_rounded,
                    color: colors.onPrimaryContainer,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      route.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: colors.onSurfaceVariant.withAlpha(127),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
