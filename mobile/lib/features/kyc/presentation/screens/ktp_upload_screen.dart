import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// KTP Upload Screen - Berdasarkan Figma/Mobile/KTP.png
///
/// UI ONLY - Functionality OCR akan dikerjakan nanti
/// Untuk sekarang: ada tombol SKIP untuk bypass KYC
class KtpUploadScreen extends ConsumerStatefulWidget {
  const KtpUploadScreen({super.key});

  @override
  ConsumerState<KtpUploadScreen> createState() => _KtpUploadScreenState();
}

class _KtpUploadScreenState extends ConsumerState<KtpUploadScreen> {
  String? _imagePath;
  bool _isLoading = false;

  // MOCK: Simulate image picker
  Future<void> _handleTakePhoto() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _imagePath = 'mock_ktp_image.jpg';
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📸 Foto KTP berhasil diambil')));
  }

  Future<void> _handleGallery() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _imagePath = 'mock_ktp_from_gallery.jpg';
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('🖼️ Foto KTP dipilih dari galeri')));
  }

  void _handleContinue() {
    if (_imagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan ambil foto KTP terlebih dahulu')));
      return;
    }

    // Navigate to selfie screen
    context.push('/kyc/selfie');
  }

  void _handleSkip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Skip KYC?'),
        content: const Text(
          'Anda bisa melengkapi KYC nanti melalui menu Profil. Beberapa fitur mungkin terbatas tanpa verifikasi KYC.',
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.go('/home'); // Skip to home
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Upload KTP',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: _handleSkip,
            child: const Text(
              'Lewati',
              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Pastikan foto KTP jelas, tidak buram, dan semua teks terbaca',
                        style: TextStyle(fontSize: 13, color: Colors.blue.shade900, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Image preview area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
                  ),
                  child: _imagePath == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card, size: 80, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada foto KTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Ambil foto KTP Anda', style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, size: 80, color: Colors.green.shade400),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Foto KTP tersimpan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(_imagePath!, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: IconButton(
                                onPressed: () {
                                  setState(() => _imagePath = null);
                                },
                                icon: const Icon(Icons.close),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.red.shade50,
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              if (_imagePath == null) ...[
                // Camera button
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _handleTakePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Ambil Foto KTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Gallery button
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _handleGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Pilih dari Galeri'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2563EB),
                      side: const BorderSide(color: Color(0xFF2563EB), width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ] else ...[
                // Continue button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Lanjutkan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
