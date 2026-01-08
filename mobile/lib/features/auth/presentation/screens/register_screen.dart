import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak cocok'), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);
    if (!mounted) return;
    context.push('/verify-otp', extra: _emailCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Buat Akun Barumu', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 10),
                      const Text('Isi data dirimu untuk menjadi bagian dari kemajuan desa.', style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF))),
                      const SizedBox(height: 28),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 28),
                        label: const Text('Lanjut Menggunakan Google', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(color: Color(0xFF374151)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.apple, color: Colors.white, size: 24),
                        label: const Text('Lanjut Menggunakan Apple ID', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(color: Color(0xFF374151)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1, color: const Color(0xFF374151))),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Atau lanjutkan menggunakan email', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                          ),
                          Expanded(child: Container(height: 1, color: const Color(0xFF374151))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _nameCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukan nama lengkap anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF6B7280)),
                          suffixText: '*',
                          suffixStyle: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: const Color(0xFF0A0C0E),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _emailCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukan nomor telepon atau alamat email anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF6B7280)),
                          suffixText: '*',
                          suffixStyle: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: const Color(0xFF0A0C0E),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _passCtrl,
                        obscureText: _obscurePass,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Minimal 8 karakter untuk password anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6B7280)),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('*', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B7280)),
                                onPressed: () => setState(() => _obscurePass = !_obscurePass),
                              ),
                            ],
                          ),
                          filled: true,
                          fillColor: const Color(0xFF0A0C0E),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _confirmCtrl,
                        obscureText: _obscureConfirm,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Masukan konfirmasi password anda',
                          hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6B7280)),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('*', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B7280)),
                                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                              ),
                            ],
                          ),
                          filled: true,
                          fillColor: const Color(0xFF0A0C0E),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1F2937))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2)),
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: _loading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: _loading
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                            : const Text('Buat Akun', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(text: 'Sudah Punya Akun? ', style: TextStyle(color: Color(0xFF9CA3AF))),
                                TextSpan(text: 'Masuk Akun', style: TextStyle(color: Color(0xFF3B82F6), decoration: TextDecoration.underline)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
