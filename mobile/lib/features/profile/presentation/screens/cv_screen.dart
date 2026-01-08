import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

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
          'CV Anda',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
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
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildExperienceSection(),
            const SizedBox(height: 24),
            _buildEducationSection(),
            const SizedBox(height: 24),
            _buildProjectSection(),
            const SizedBox(height: 24),
            _buildCertificationSection(),
            const SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.person_outline, 'Profil'),
          const SizedBox(height: 20),
          _buildTextField('Nama Lengkap', 'Dadang Surandang'),
          const SizedBox(height: 16),
          _buildTextField('Email', 'dadanggege@gmail.com'),
          const SizedBox(height: 16),
          _buildTextField('Nomor Telepon', '08125000200F0'),
          const SizedBox(height: 16),
          _buildTextField('Lokasi', 'Bandung, Jawa Barat'),
          const SizedBox(height: 16),
          _buildTextField('LinkedIn (Opsional)', 'linkedin.com/dadang-surandang'),
          const SizedBox(height: 16),
          _buildTextField('Situs Web (Opsional)', '-'),
          const SizedBox(height: 16),
          _buildTextField(
            'Ringkasan Profesional',
            'UI/UX Designer with 5 years of experience specializing in user-centered design and front-end development...',
            maxLines: 8,
          ),
          const SizedBox(height: 24),
          Text(
            'Keahlian',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSkillChip('UI UX Design'),
              _buildSkillChip('Fotografi'),
              _buildSkillChip('Editing'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.work_outline, 'Pengalaman'),
          const SizedBox(height: 20),
          _buildSubHeader('Pengalaman #1'),
          const SizedBox(height: 16),
          _buildTextField('Posisi/Jabatan', 'UI Designer'),
          const SizedBox(height: 16),
          _buildTextField('Nama Perusahaan', 'Nama Perusahan'),
          const SizedBox(height: 16),
          _buildTextField('Lokasi', 'Bandung, Jawa Barat'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Tanggal Mulai', 'DD/MM/YYYY')),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('Tanggal Berakhir', 'DD/MM/YYYY')),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Deskripsi (Opsional)', 'Mendesain ulang tampilan bla bla bla', maxLines: 3),
          const SizedBox(height: 24),
          _buildAddButton('Tambah Pengalaman'),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.school_outlined, 'Pendidikan'),
          const SizedBox(height: 20),
          _buildSubHeader('Pendidikan #1'),
          const SizedBox(height: 16),
          _buildTextField('Sekolah/Universitas', 'SMK Telkom Jakarta'),
          const SizedBox(height: 16),
          _buildTextField('Gelar', '-'),
          const SizedBox(height: 16),
          _buildTextField('Bidang Studi', 'Rekayasa Perangkat Lunak'),
          const SizedBox(height: 16),
          _buildTextField('Nilai Akhir', '95,05'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Tanggal Mulai', 'DD/MM/YYYY')),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('Tanggal Berakhir', 'DD/MM/YYYY')),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Deskripsi (Opsional)', 'Mendesain ulang tampilan bla bla bla', maxLines: 3),
          const SizedBox(height: 24),
          _buildAddButton('Tambah Pendidikan'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF21262B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSubHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline, color: Color(0xFF919AA6), size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: hint == '-' || hint.contains('bla bla') || hint.contains('DD/MM') ? null : hint,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: const Color(0xFF919AA6), fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: const Color(0xFF919AA6).withOpacity(0.5), fontSize: 14),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF414C5C), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDCEAFC), width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF414C5C)),
        color: Colors.transparent,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFFDCEAFC),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddButton(String label) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF414C5C)),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Color(0xFF919AA6), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF919AA6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProjectSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.business_center_outlined, 'Proyek'),
          const SizedBox(height: 24),
          _buildAddButton('Tambah Proyek'),
        ],
      ),
    );
  }

  Widget _buildCertificationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF050708),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.card_membership_outlined, 'Sertifikasi'),
          const SizedBox(height: 24),
          _buildAddButton('Tambah Sertifikasi'),
        ],
      ),
    );
  }
}
