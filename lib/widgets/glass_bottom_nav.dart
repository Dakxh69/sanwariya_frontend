import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class GlassBottomNav extends StatelessWidget {
  final String currentPath;

  const GlassBottomNav({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF353534).withValues(alpha: 0.6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 48,
                offset: Offset(0, -24),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavItem(icon: Icons.home, label: 'Home', isActive: currentPath == '/', onTap: () { if (currentPath != '/') context.go('/'); }),
              _NavItem(icon: Icons.storefront, label: 'Shop', isActive: currentPath == '/collection', onTap: () { if (currentPath != '/collection') context.push('/collection'); }),
              _NavItem(icon: Icons.grid_view, label: 'Categories', isActive: currentPath == '/browse', onTap: () { if (currentPath != '/browse') context.push('/browse'); }),
              _NavItem(icon: Icons.shopping_bag_outlined, label: 'Cart', isActive: currentPath == '/cart', onTap: () { if (currentPath != '/cart') context.push('/cart'); }),
              _NavItem(icon: Icons.person_outline, label: 'Account', isActive: currentPath == '/login', onTap: () => context.push('/login')),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isActive ? AppTheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.primary : AppTheme.onSurface.withValues(alpha: 0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isActive ? AppTheme.primary : AppTheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 10,
                    letterSpacing: 1.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
