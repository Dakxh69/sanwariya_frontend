import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'nav_menu.dart';

class SanwariyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentPath;
  final Color backgroundColor;
  final Color titleColor;
  final bool showMenuOnDesktop;

  const SanwariyaAppBar({
    super.key,
    required this.currentPath,
    this.backgroundColor = AppTheme.surface,
    this.titleColor = AppTheme.primary,
    this.showMenuOnDesktop = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(86);

  void _pushIfNeeded(BuildContext context, String route) {
    if (currentPath == route) return;
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: Text(
        'Sanwariya\nImitation',
        style: GoogleFonts.playfairDisplay(
          textStyle: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: titleColor, height: 1.05),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        _CartActionIcon(onPressed: () => _pushIfNeeded(context, '/cart')),
        IconButton(
          icon: const Icon(Icons.person_outline),
          color: AppTheme.onSurface,
          onPressed: () => _pushIfNeeded(context, '/login'),
        ),
        if (showMenuOnDesktop || !isDesktop)
          IconButton(
            icon: const Icon(Icons.menu),
            color: AppTheme.onSurface,
            onPressed: () => NavMenu.show(context, currentPath: currentPath),
          ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _CartActionIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const _CartActionIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Selector<MockDataProvider, int>(
      selector: (_, provider) => provider.cartCount,
      builder: (context, count, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              color: AppTheme.onSurface,
              onPressed: onPressed,
            ),
            if (count > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: AppTheme.onPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
