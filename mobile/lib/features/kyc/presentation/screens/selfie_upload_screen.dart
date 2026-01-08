import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Selfie Capture Screen - Berdasarkan Figma/Mobile/Swafoto.png
///
/// UI ONLY - Functionality face detection akan dikerjakan nanti
/// Untuk sekarang: ada tombol SKIP untuk bypass KYC
class SelfieUploadScreen extends ConsumerStatefulWidget {
  const SelfieUploadScreen({super.key});

  @override
  ConsumerState<SelfieUploadScreen> createState() => _SelfieUploadScreenState();
}

class _SelfieUploadScreenState extends ConsumerState<SelfieUploadScreen> {
  String? _imagePath;
  bool _isLoading = false;
  bool _faceDetected = false;

  // MOCK: Simulate selfie capture
  Future<void> _handleCapture() async {
    setState(() {
      _isLoading = true;
      _faceDetected = false;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _imagePath = 'mock_selfie.jpg';
      _faceDetected = true;
      _isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('✅ Wajah terdeteksi! Foto berhasil diambil')));
  }

  void _handleSubmit() {
    if (_imagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan ambil foto selfie terlebih dahulu')));
      return;
    }

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        title: const Text('KYC Berhasil Dikirim!'),
        content: const Text(
          'Data KYC Anda sedang dalam proses verifikasi. Anda akan mendapat notifikasi setelah verifikasi selesai.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.go('/home'); // Navigate to home
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
            child: const Text('Ke Beranda'),
          ),
        ],
      ),
    );
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Foto Selfie',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
        child: Column(
          children: [
            // Instructions
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white.withOpacity(0.9)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Posisikan wajah di dalam bingkai oval',
                      style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ),

            // Camera preview area with face guide
            Expanded(
              child: Stack(
                children: [
                  // Camera preview placeholder
                  Container(
                    color: Colors.grey.shade900,
                    child: Center(
                      child: _imagePath == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, size: 80, color: Colors.white.withOpacity(0.5)),
                                const SizedBox(height: 16),
                                Text(
                                  'Kamera akan terbuka\nketika fitur aktif',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, size: 80, color: Colors.green.shade400),
                                const SizedBox(height: 16),
                                const Text(
                                  'Foto Selfie Berhasil!',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(_imagePath!, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                              ],
                            ),
                    ),
                  ),

                  // Face guide overlay
                  if (_imagePath == null)
                    Center(
                      child: Container(
                        width: 280,
                        height: 360,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _faceDetected ? Colors.green : Colors.white.withOpacity(0.6),
                            width: 3,
                          ),
                        ),
                      ),
                    ),

                  // Retake button if photo exists
                  if (_imagePath != null)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _imagePath = null;
                            _faceDetected = false;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Bottom controls
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.black,
              child: Column(
                children: [
                  // Status text
                  if (_imagePath == null)
                    Text(
                      _isLoading ? 'Mendeteksi wajah...' : 'Tekan tombol untuk mengambil foto',
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                    ),

                  const SizedBox(height: 16),

                  // Capture/Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _imagePath == null
                        ? ElevatedButton.icon(
                            onPressed: _isLoading ? null : _handleCapture,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.camera),
                            label: Text(_isLoading ? 'Memproses...' : 'Ambil Foto'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'Kirim Data KYC',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
