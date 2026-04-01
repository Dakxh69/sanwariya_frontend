import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_bottom_nav.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GlassBottomNav(currentPath: '/contact'),
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/')),
        title: Text(
          'SANWARIYA',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppTheme.primary,
            letterSpacing: 4.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: AppTheme.surfaceContainerLow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Get In Touch',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 48,
                      foreground: Paint()..shader = const LinearGradient(
                        colors: [AppTheme.primary, AppTheme.onSurface],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Our master artisans and concierge team are available for bespoke consultations and inquiries regarding our heritage collections.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Us a Message',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 2, width: 40, color: AppTheme.primary),
                  const SizedBox(height: 48),
                  
                  _buildTextField(context, label: 'FULL NAME', hint: 'E.g., Daksh'),
                  const SizedBox(height: 32),
                  _buildTextField(context, label: 'EMAIL ADDRESS', hint: 'daksh@atelier.com'),
                  const SizedBox(height: 32),
                  _buildTextField(context, label: 'PHONE NUMBER', hint: '+91 7206889607'),
                  const SizedBox(height: 32),
                  _buildTextField(context, label: 'SUBJECT', hint: 'Bespoke Commission'),
                  const SizedBox(height: 32),
                  _buildTextField(context, label: 'MESSAGE', hint: 'Describe your inquiry...', maxLines: 4),
                  const SizedBox(height: 48),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // API_HOOK: onPressed → POST /api/contact { name, email, phone, subject, message }
                      // Show success/failure snackbar based on response
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.onPrimary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SEND MESSAGE',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0,
                              color: AppTheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.arrow_right_alt, color: AppTheme.onPrimary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Contact Information
            Container(
              color: AppTheme.surfaceContainerLow,
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  _buildInfoRow(context, icon: Icons.location_on, label: 'OUR MAISON', text: 'Govind Tower, Shop No. 4-5,\nnear Shyam Nagar Metro Station,\nNew Sanganer Rd, Sodala,\nJaipur, Rajasthan 302019'),
                  const SizedBox(height: 32),
                  _buildInfoRow(context, icon: Icons.call, label: 'PRIMARY CONCIERGE', text: '+91 6378564718'),
                  const SizedBox(height: 32),
                  _buildInfoRow(context, icon: Icons.mail, label: 'GENERAL INQUIRIES', text: 'support@sanwariyaimitation.com'),
                  const SizedBox(height: 32),
                  _buildInfoRow(context, icon: Icons.schedule, label: 'ATELIER HOURS', text: 'Monday - Saturday: 09:30 AM - 08:00 PM\nSunday: Closed'),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10,
            letterSpacing: 3.0,
            color: AppTheme.outline,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 14,
              letterSpacing: 1.0,
              color: AppTheme.outline.withValues(alpha: 0.4),
            ),
            filled: true,
            fillColor: AppTheme.surfaceContainerLowest,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primary),
            ),
          ),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String label, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.primary),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 3.0,
                  color: AppTheme.outline,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
