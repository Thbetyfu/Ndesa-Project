import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    'Lowongan',
    'Promo',
    'Transaksi',
    'Info',
    'Penukaran'
  ];

  // Mock Data
  final List<Map<String, dynamic>> _allNotifications = [
    {
      'title': 'Selamat! Lamaranmu Diterima',
      'body':
          'Lamaran kerjamu untuk posisi Pengrajin Daur Ulang di Dinas Lingkungan Hidup telah diterima. Klik untuk info selanjutnya!',
      'time': '3 Jam',
      'type': NotificationType.vacancy,
      'isUnread': true,
      'category': 'Lowongan',
      'section': 'Hari Ini',
    },
    {
      'title': 'Update Status Lamaran Kerjamu',
      'body':
          'Kali ini belum rezeki. Lamaranmu di Dinas Perhubungan belum dapat lanjut. Jangan patah semangat, masih banyak jalan lain menanti!',
      'time': '1 hari lalu',
      'type': NotificationType.vacancy,
      'isUnread': false,
      'category': 'Lowongan',
      'section': 'Kemarin',
    },
    {
      'title': 'Pembayaranmu sudah terverifikasi',
      'body':
          'Pembayaranmu sudah kami terima, mohon tunggu konfirmasi selanjutnya.',
      'time': '1 hari lalu',
      'type': NotificationType.info,
      'isUnread': false,
      'category': 'Info',
      'section': 'Kemarin',
    },
    {
      'title': 'Pembayaranmu sudah terverifikasi',
      'body':
          'Pembayaranmu sudah kami terima, mohon tunggu konfirmasi selanjutnya.',
      'time': '1 hari lalu',
      'type': NotificationType.info,
      'isUnread': false,
      'category': 'Info',
      'section': 'Kemarin',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _filters[_selectedFilterIndex];
    final filteredNotifications = _allNotifications
        .where((n) => n['category'] == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildFilterSection(),
            const SizedBox(height: 24),
            Expanded(
              child: filteredNotifications.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildNotificationList(filteredNotifications),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationList(List<Map<String, dynamic>> notifications) {
    List<Widget> widgets = [];
    String? currentSection;

    for (var notification in notifications) {
      if (notification['section'] != currentSection) {
        if (widgets.isNotEmpty) widgets.add(const SizedBox(height: 24));
        currentSection = notification['section'];
        widgets.add(_buildSectionHeader(currentSection!));
        widgets.add(const SizedBox(height: 12));
      } else {
        widgets.add(const SizedBox(height: 12));
      }

      widgets.add(_buildNotificationCard(
        title: notification['title'],
        body: notification['body'],
        time: notification['time'],
        type: notification['type'],
        isUnread: notification['isUnread'],
      ));
    }
    widgets.add(const SizedBox(height: 24));
    return widgets;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/No-Content.svg',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'Belum ada notifikasi',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Yuk, coba pakai filter lainnya',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Color(0xFF98A7B9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(20),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFFDCEAFC),
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              'Notifikasi',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDCEAFC),
              ),
            ),
          ),
          const SizedBox(width: 24), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length + 1, // +1 for the checkmark button
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == _filters.length) {
            return Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF21262B),
                border: Border.all(color: const Color(0xFF292D33)),
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF98A7B9),
                size: 18,
              ),
            );
          }

          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4E8CCA) : const Color(0xFF292D33),
                ),
                color: isSelected ? const Color(0xFF4E8CCA).withOpacity(0.1) : Colors.transparent,
              ),
              child: Text(
                _filters[index],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: isSelected ? const Color(0xFF4E8CCA) : const Color(0xFF98A7B9),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFDCEAFC),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String body,
    required String time,
    required NotificationType type,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF292D33)),
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
            Color(0xFF13181D),
            Color(0xFF070809),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF04121F),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: type == NotificationType.vacancy
                ? SvgPicture.asset(
                    'assets/icons/briefcase.svg',
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF245DA6),
                      BlendMode.srcIn,
                    ),
                  )
                : const Icon(
                    Icons.info,
                    color: Color(0xFF7C3AED), // Purple for info
                    size: 24,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type == NotificationType.vacancy ? 'Lowongan' : 'Info',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF556171),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF556171),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDCEAFC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF98A7B9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF556171),
            size: 20,
          ),
        ],
      ),
    );
  }
}

enum NotificationType { vacancy, info }
