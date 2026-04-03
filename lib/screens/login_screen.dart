import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/sanwariya_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneCtrl = TextEditingController();
  String? _errorText;
  bool _submitted = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _isValidPhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'\s|-'), '');
    return RegExp(r'^[6-9]\d{9}$').hasMatch(cleaned);
  }

  void _onPhoneChanged(String value) {
    if (_submitted) {
      setState(() {
        _errorText = _isValidPhone(value) ? null : _getErrorMessage(value);
      });
    }
  }

  String? _getErrorMessage(String value) {
    if (value.isEmpty) return 'Phone number is required';
    if (value.length < 10) return 'Enter a 10-digit mobile number';
    if (!RegExp(r'^[6-9]').hasMatch(value)) {
      return 'Indian mobile numbers start with 6, 7, 8 or 9';
    }
    if (!_isValidPhone(value)) {
      return 'Enter a valid 10-digit Indian mobile number';
    }
    return null;
  }

  void _submit() {
    setState(() {
      _submitted = true;
      _errorText = _getErrorMessage(_phoneCtrl.text.trim());
    });
    if (_errorText == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent to +91 ${_phoneCtrl.text.trim()}'),
          backgroundColor: AppTheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: const SanwariyaAppBar(currentPath: '/login'),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 768;

            Widget formContent = Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You will receive a 6-digit code for verification',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Text(
                    'PHONE NUMBER',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: _errorText != null
                          ? AppTheme.primary
                          : AppTheme.outline,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '+91',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.expand_more,
                        color: AppTheme.outline,
                        size: 16,
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 1,
                        height: 24,
                        color: AppTheme.outlineVariant,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: _onPhoneChanged,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(fontSize: 18, letterSpacing: 2.0),
                          decoration: InputDecoration(
                            hintText: 'Enter your mobile number',
                            counterText: '',
                            hintStyle: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 18,
                                  letterSpacing: 2.0,
                                  color: AppTheme.outline.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      if (_submitted && _errorText == null)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                  Divider(
                    color: _errorText != null
                        ? AppTheme.primary
                        : AppTheme.outlineVariant,
                    thickness: _errorText != null ? 2 : 1,
                  ),

                  if (_errorText != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppTheme.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _errorText!,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppTheme.primary, fontSize: 11),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.onSurface,
                        foregroundColor: AppTheme.surfaceContainerLowest,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'SEND OTP',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: AppTheme.surfaceContainerLowest,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppTheme.outlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 10,
                                letterSpacing: 2.0,
                                color: AppTheme.outline,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppTheme.outlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.outlineVariant.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'GOOGLE',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(fontSize: 10, letterSpacing: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.outlineVariant.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'APPLE ID',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(fontSize: 10, letterSpacing: 2.0),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: AppTheme.outline,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: 'By continuing, you agree to our\n',
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              color: AppTheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppTheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      color: AppTheme.surfaceContainerLow,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 64,
                          color: AppTheme.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: formContent),
                ],
              );
            }
            return formContent;
          },
        ),
      ),
    );
  }
}
