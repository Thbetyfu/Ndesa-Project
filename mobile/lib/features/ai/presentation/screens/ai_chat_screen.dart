import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<String> _suggestions = [
    'Pipa rumah saya bocor',
    'Tolong carikan rumah kepala desa',
    'Dimana masjid terdekat?',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF070809),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFF070809),
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF050708),
        appBar: _buildAppBar(context),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            const Spacer(),
            _buildSuggestions(),
            const SizedBox(height: 16),
            _buildPremiumInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF050708),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Tanya ke Junaedi',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Color(0xFF98A7B9)),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF292D33)),
            ),
            child: Text(
              _suggestions[index],
              style: const TextStyle(color: Color(0xFF98A7B9), fontSize: 12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumInputArea() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: RadialGradient(
          center: Alignment(0.0, -1.0),
          radius: 1.5,
          colors: [Color(0xFF414C5C), Color(0xFF1F2226)],
        ),
      ),
      padding: const EdgeInsets.only(top: 1.2),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
          gradient: RadialGradient(
            center: Alignment(0.0, -1.0),
            radius: 1.6,
            colors: [Color(0xFF13181D), Color(0xFF070809)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField dengan background transparan penuh
            TextField(
              controller: _messageController,
              cursorColor: const Color(0xFF4E8CCA),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Apa yang ingin anda tanyakan?',
                hintStyle: TextStyle(
                  color: const Color(0xFFCEDEF2).withOpacity(0.4),
                ),
                filled: false, // PENTING: Matikan filled
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildInputIcon(Icons.add),
                const SizedBox(width: 10),
                _buildCapsuleAction(Icons.camera_alt_outlined, 'Ambil Foto'),
                const Spacer(),
                _buildInputIcon(Icons.mic_none),
                const SizedBox(width: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4E8CCA),
                  ),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Color(0xFF050708),
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF292D33)),
        color: const Color(0xFF08090A),
      ),
      child: Icon(icon, color: const Color(0xFF98A7B9), size: 18),
    );
  }

  Widget _buildCapsuleAction(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33)),
        color: const Color(0xFF08090A),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF98A7B9), size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF98A7B9), fontSize: 12),
          ),
        ],
      ),
    );
  }
}