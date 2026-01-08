import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock/profile_mock_data.dart';

/// Profile Screen - Refined with Grouped Menu, Dividers & Functional Bottom Navbar
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileMockData.getUserProfile();
    final progress = ProfileMockData.getProgressData();
    final menuItems = ProfileMockData.getMenuItems();

    const bgBlack = Color(0xFF050505);

    return Scaffold(
      backgroundColor: bgBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildGradientCard(
                child: _buildHeaderContent(profile),
              ),
              const SizedBox(height: 24),

              // Progress Card
              _buildGradientCard(
                child: _buildProgressContent(progress),
              ),
              const SizedBox(height: 24),

              // CV Card
              _buildGradientCard(
                child: _buildCVContent(context),
                onTap: () {
                  context.push('/cv');
                },
              ),
              const SizedBox(height: 24),

              // Menu List (Grouped in one card)
              _buildGradientCard(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < menuItems.length; i++) ...[
                      _buildMenuItem(context, menuItems[i]),
                      if (i < menuItems.length - 1)
                        const Divider(
                          color: Color(0xFF1F222A),
                          height: 1,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              
              const SizedBox(height: 20), // Spacing before bottom padding
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar removed as it is now handled by MainScreen (ShellRoute)
    );
  }

  /// Reusable Card with Radial Gradient Background, Gradient Border, and Shadow
  Widget _buildGradientCard({
    required Widget child,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
  }) {
    // XML Reference Colors: #13181D (0%) -> #070809 (100%)
    const gradientColors = [Color(0xFF13181D), Color(0xFF070809)];
    
    // Border Gradient (Simulated)
    const borderColors = [Color(0xFF2A2D35), Color(0xFF111315)];

    final container = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(2), // Border width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const RadialGradient(
            colors: borderColors,
            radius: 1.5,
            center: Alignment.topLeft,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const RadialGradient(
              colors: gradientColors,
              center: Alignment.center,
              radius: 0.8,
              stops: [0.0, 1.0],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: padding ?? const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

    return container;
  }

  Widget _buildHeaderContent(Map<String, dynamic> profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF2A2D35), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/avatar_placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF1F222A),
                  child: const Icon(Icons.person, color: Color(0xFF555555)),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      profile['name'],
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F222A),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF2A2D35)),
                    ),
                    child: Text(
                      profile['nik'],
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Pria, 34 Tahun',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatusBadge(
                    label: 'Terverifikasi',
                    color: const Color(0xFF22C55E),
                    icon: Icons.check_circle,
                    bgColor: const Color(0xFF052E16),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusBadge(
                    label: 'Menganggur',
                    color: const Color(0xFFEF4444),
                    icon: Icons.remove_circle,
                    bgColor: const Color(0xFF450A0A),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge({
    required String label, 
    required Color color, 
    required IconData icon,
    required Color bgColor
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressContent(Map<String, dynamic> progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F222A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2D35)),
              ),
              child: SvgPicture.asset(
                'assets/icons/briefcase.svg',
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Progress Perjalanan Anda',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        Row(
          children: [
            _buildOutlineTag('Graphic Designer'),
            const SizedBox(width: 8),
            _buildOutlineTag('Pemula'),
          ],
        ),
        
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0B0C).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2A2D35), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2A2D35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.info_outline, size: 14, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Pertemuan selanjutnya',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F222A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2A2D35)),
                    ),
                    child: Text(
                      progress['upcomingEvent']['date'],
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 4),
                  Text(
                    progress['upcomingEvent']['location'],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Color(0xFFD1D5DB),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              Text(
                progress['upcomingEvent']['description'],
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOutlineTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2A2D35), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color(0xFFD1D5DB),
        ),
      ),
    );
  }

  Widget _buildCVContent(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1F222A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2A2D35)),
          ),
          child: SvgPicture.asset(
            'assets/icons/Paper.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CV Anda',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Color(0xFF4B5563), size: 24),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, String> item) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navigasi ke ${item['title']}')));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                item['icon']!,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (item['description'] != null && item['description']!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        item['description']!,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF4B5563), size: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF450A0A).withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout, color: Color(0xFFEF4444), size: 20),
            SizedBox(width: 8),
            Text(
              'Keluar Aplikasi',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4444),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
