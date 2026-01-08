import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final String location;

  const MainScreen({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      body: child,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    // Determine selected index based on current location
    int selectedIndex = 0;
    if (location.startsWith('/home')) {
      selectedIndex = 0;
    } else if (location.startsWith('/lowongan')) {
      selectedIndex = 1;
    } else if (location.startsWith('/ai')) {
      selectedIndex = 2;
    } else if (location.startsWith('/profile')) {
      selectedIndex = 3;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            Color(0xFF13181D), // Center color
            Color(0xFF070809), // Outer color
          ],
          stops: [0.0, 1.0],
        ),
        border: const Border(top: BorderSide(color: Color(0xFF1F2937), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(context, 0, 'assets/icons/nav_home.svg', 'Home', selectedIndex),
              _buildNavItem(context, 1, 'assets/icons/nav_lowongan.svg', 'Lowongan', selectedIndex),
              _buildNavItem(context, 2, 'assets/icons/nav_AI.svg', 'AI', selectedIndex),
              _buildNavItem(context, 3, 'assets/icons/nav_profile.svg', 'Profile', selectedIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String assetPath, String label, int selectedIndex) {
    final isSelected = selectedIndex == index;
    
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/lowongan');
            break;
          case 2:
            context.go('/ai');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgPicture.asset(
          assetPath,
          width: 80,
          height: 60,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : const Color(0xFF6B7280),
            BlendMode.srcIn,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
