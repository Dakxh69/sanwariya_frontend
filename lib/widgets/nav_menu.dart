import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import 'sanwariya_app_bar.dart';

class NavMenu extends StatelessWidget {
  final String currentPath;

  const NavMenu({super.key, required this.currentPath});

  static Future<void> show(BuildContext context, {String currentPath = '/'}) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: true,
      barrierLabel: 'Close Menu',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return NavMenu(currentPath: currentPath);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuBackground = AppTheme.surface.withValues(alpha: 0.95);

    return Scaffold(
      backgroundColor: menuBackground,
      appBar: SanwariyaAppBar(
        currentPath: currentPath,
        backgroundColor: menuBackground,
        showMenuOnDesktop: true,
        showCloseMenuIcon: true,
        onMenuPressed: () => Navigator.pop(context),
        onCartPressed: () {
          Navigator.pop(context);
          context.push('/cart');
        },
        onUserPressed: () {
          Navigator.pop(context);
          context.push('/login');
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppTheme.surfaceContainerHighest, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              children: [
                _MenuItem(title: 'Home', path: '/', currentPath: currentPath),
                _MenuItem(
                  title: 'Shop',
                  path: '/collection',
                  currentPath: currentPath,
                ),
                _MenuItem(
                  title: 'Categories',
                  path: '/browse',
                  currentPath: currentPath,
                ),
                _MenuItem(
                  title: 'Offers',
                  path: '/offers',
                  currentPath: currentPath,
                ),
                _MenuItem(
                  title: 'Track Order',
                  path: '/track',
                  currentPath: currentPath,
                ),
                _MenuItem(
                  title: 'About',
                  path: '/about',
                  currentPath: currentPath,
                ),
                _MenuItem(
                  title: 'Contact Us',
                  path: '/contact',
                  currentPath: currentPath,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String path;
  final String currentPath;

  const _MenuItem({
    required this.title,
    required this.path,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentPath == path;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (!isActive) {
            context.push(path);
          }
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isActive ? AppTheme.primary : AppTheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
