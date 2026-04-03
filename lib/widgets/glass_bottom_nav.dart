import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlassBottomNav extends StatelessWidget {
  final String currentPath;

  const GlassBottomNav({super.key, required this.currentPath});

  static const _navHeight = 80.0;

  static const _glassDecoration = BoxDecoration(
    color: Color(0x99353534),
    boxShadow: [
      BoxShadow(color: Colors.black54, blurRadius: 48, offset: Offset(0, -24)),
    ],
  );

  void _navigate(BuildContext context, String route, {bool replace = false}) {
    if (currentPath == route) {
      return;
    }
    if (replace) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: _navHeight,
            decoration: _glassDecoration,
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    onTap: () => _navigate(context, '/', replace: true),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.add_circle_outline,
                    label: 'Shop',
                    onTap: () => _navigate(context, '/collection'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.grid_view_outlined,
                    label: 'Categories',
                    onTap: () => _navigate(context, '/browse'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Cart',
                    onTap: () => _navigate(context, '/cart'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.person_outline,
                    label: 'Account',
                    onTap: () => _navigate(context, '/login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  static const _itemColor = Color(0xFFF2CA50);

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _itemColor, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: labelStyle?.copyWith(
                color: _itemColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
