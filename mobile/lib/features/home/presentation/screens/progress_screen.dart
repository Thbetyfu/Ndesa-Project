import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050708),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Progress Anda',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainCard(),
            const SizedBox(height: 24),
            _buildLearningPathHeader(),
            const SizedBox(height: 16),
            _buildOnlineTrainingList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return _buildGradientContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F222A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF374151)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/briefcase.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  placeholderBuilder: (context) => const Icon(Icons.work, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Progress Perjalanan Anda',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTag('Graphic Designer'),
              const SizedBox(width: 8),
              _buildTag('Pemula'),
            ],
          ),
          const SizedBox(height: 24),
          _buildOfflineMeetingSection(),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2A2D35)),
        color: Colors.transparent,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFFD1D5DB),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOfflineMeetingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2D35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.info_outline, color: Color(0xFF9CA3AF), size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Pertemuan Offline Masih Terkunci',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Anda harus menyelesaikan pelatihan mandiri secara online terlebih dahulu untuk mengakses pelatihan offline oleh praktisi kami.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPathHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Alur Pembelajaran',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1F222A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2A2D35)),
          ),
          child: Text(
            '1/5 Materi Dipelajari',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOnlineTrainingList() {
    return _buildGradientContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pelatihan Online Mandiri',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _buildModuleItem(
            number: '1',
            title: 'Kenalan Dengan Designer',
            description: 'Sebelum terjun ke dunia graphic design, yuk kenalan dulu sama istilah-istilahnya',
            isCompleted: true,
          ),
          _buildModuleItem(
            number: '2',
            title: 'Dasar komposisi visual',
            description: 'Dasar komposisi visual yang perlu kita pelajari',
            isCompleted: false,
          ),
          _buildModuleItem(
            number: '3',
            title: 'Prinsip Desain',
            description: 'Prinsip dalam membuat sebuah design',
            isCompleted: false,
          ),
          _buildModuleItem(
            number: '4',
            title: 'Prinsip Desain',
            description: 'Prinsip dalam membuat sebuah design',
            isCompleted: false,
          ),
          _buildModuleItem(
            number: '5',
            title: 'Prinsip Desain',
            description: 'Prinsip dalam membuat sebuah design',
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildGradientContainer({required Widget child}) {
    const gradientColors = [Color(0xFF13181D), Color(0xFF070809)];
    const borderColors = [Color(0xFF2A2D35), Color(0xFF111315)];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(1), // Border width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const RadialGradient(
            colors: borderColors,
            radius: 1.5,
            center: Alignment.topLeft,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(31),
            gradient: const RadialGradient(
              colors: gradientColors,
              center: Alignment.center,
              radius: 0.8,
              stops: [0.0, 1.0],
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildModuleItem({
    required String number,
    required String title,
    required String description,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2D35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  number,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFF064E3B).withOpacity(0.3) : const Color(0xFF2A2D35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isCompleted ? 'Dipelajari' : 'Belum Dipelajari',
                style: GoogleFonts.inter(
                  color: isCompleted ? const Color(0xFF34D399) : const Color(0xFF9CA3AF),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
