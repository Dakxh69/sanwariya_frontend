import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/sanwariya_app_bar.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showBottom = Responsive.showBottomNav(context);
    final horizontalPadding = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 12),
      tablet: const EdgeInsets.symmetric(horizontal: 32),
      desktop: const EdgeInsets.symmetric(horizontal: 100),
    );

    return Scaffold(
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/track')
          : null,
      backgroundColor: AppTheme.surface,
      appBar: const SanwariyaAppBar(currentPath: '/track'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final formCardWidth = Responsive.value<double>(
            context,
            mobile: 360,
            tablet: 520,
            desktop: 640,
          );

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: horizontalPadding,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Track Your Order',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0xFFD8B23B),
                            fontSize: Responsive.value<double>(
                              context,
                              mobile: 40,
                              tablet: 44,
                              desktop: 48,
                            ),
                            height: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: formCardWidth,
                          child: const _TrackingFormCard(),
                        ),
                        SizedBox(height: showBottom ? 20 : 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TrackingFormCard extends StatelessWidget {
  const _TrackingFormCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C23),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2C35)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter Tracking Number',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF8E9AB3),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFFF4F4F6),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFD8B23B)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFD8B23B)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFD8B23B),
                  width: 1.6,
                ),
              ),
            ),
            style: GoogleFonts.inter(
              color: const Color(0xFF1B1C23),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD8B23B),
                foregroundColor: const Color(0xFF151515),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Track Order',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
