import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Login Screen - Berdasarkan Figma/Mobile/Login.png
///
/// UI ONLY - Functionality akan dikerjakan nanti
/// Untuk sekarang: mock login langsung navigate ke home
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // MOCK LOGIN - Langsung navigate tanpa API call
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (!mounted) return;

    // Navigate to home (skip KYC untuk sekarang)
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SVG Background from Figma
          Positioned.fill(child: SvgPicture.asset('assets/images/background.svg', fit: BoxFit.cover)),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      // Title
                      const Text(
                        'Masuk Ke Akunmu',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Selamat datang kembali! Silakan masuk untuk melanjutkan.',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15, color: Color(0xFF9CA3AF), height: 1.5),
                      ),

                      const SizedBox(height: 32),

                      // Google Sign In Button
                      SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Google Sign In akan segera hadir'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.grey.shade800,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1F2937),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          icon: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://www.google.com/favicon.ico'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: const SizedBox.shrink(),
                          ),
                          label: const Text(
                            'Lanjut Menggunakan Google',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Apple Sign In Button
                      SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Apple Sign In akan segera hadir'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.grey.shade800,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1F2937),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.apple, size: 24),
                          label: const Text(
                            'Lanjut Menggunakan Apple ID',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Divider with text
                      Row(
                        children: [
                          Expanded(child: Container(height: 1, color: const Color(0xFF374151))),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Atau lanjutkan menggunakan email',
                              style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                            ),
                          ),
                          Expanded(child: Container(height: 1, color: const Color(0xFF374151))),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukan nomor telepon atau email anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                          prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF6B7280), size: 20),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                '*',
                                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF0F172A),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email atau nomor telepon tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukan kata sandi anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF6B7280), size: 20),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Text(
                                  '*',
                                  style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF6B7280),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() => _obscurePassword = !_obscurePassword);
                                },
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF374151)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF0F172A),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Remember me & Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remember me checkbox
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() => _rememberMe = value ?? false);
                                  },
                                  activeColor: const Color(0xFF3B82F6),
                                  checkColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFF374151), width: 1.5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Ingat Saya', style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF))),
                            ],
                          ),

                          // Forgot password link
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Fitur lupa password akan segera hadir'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.grey.shade800,
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Lupa kata sandi anda?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Login button
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF3B82F6).withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Masuk',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Skip login button
                      Center(
                        child: TextButton(
                          onPressed: () => context.push('/home'),
                          child: const Text(
                            'Masuk tanpa akun',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum Punya Akun? ', style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF))),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 36),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Buat Akun',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3B82F6),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF3B82F6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Terms and Privacy
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.5),
                            children: [
                              TextSpan(text: 'Dengan melanjutkan, kamu menyetujui '),
                              TextSpan(
                                text: 'Ketentuan Layanan',
                                style: TextStyle(decoration: TextDecoration.underline, color: Color(0xFF9CA3AF)),
                              ),
                              TextSpan(text: ' dan\n'),
                              TextSpan(
                                text: 'Kebijakan Privasi',
                                style: TextStyle(decoration: TextDecoration.underline, color: Color(0xFF9CA3AF)),
                              ),
                              TextSpan(text: ' kami.'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
