import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class VacancyScreen extends StatefulWidget {
  const VacancyScreen({super.key});

  @override
  State<VacancyScreen> createState() => _VacancyScreenState();
}

class _VacancyScreenState extends State<VacancyScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'Semua',
    'Fulltime',
    'Contract',
    'Part-time',
    'Freelance',
    'Internship'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildCategoryList(),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSectionTitle('Rekomendasi Lowongan'),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    title: 'Graphic Designer',
                    company: 'Kreasi Digital Desa',
                    location: 'Remote',
                    type: 'Fulltime',
                    level: 'Pemula',
                    salary: 'Rp 2.500.000',
                    postedTime: '2 hari yang lalu',
                    logoPath: 'assets/icons/briefcase.svg',
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    title: 'UI/UX Designer',
                    company: 'Desa Maju Tech',
                    location: 'Kantor Desa',
                    type: 'Contract',
                    level: 'Menengah',
                    salary: 'Rp 4.000.000',
                    postedTime: '5 jam yang lalu',
                    logoPath: 'assets/icons/briefcase.svg',
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    title: 'Social Media Specialist',
                    company: 'BUMDes Sejahtera',
                    location: 'Hybrid',
                    type: 'Part-time',
                    level: 'Pemula',
                    salary: 'Rp 1.500.000',
                    postedTime: '1 hari yang lalu',
                    logoPath: 'assets/icons/briefcase.svg',
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced header dengan design yang mirip dengan contoh
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Search Bar dengan gradient border seperti di design
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const RadialGradient(
                  center: Alignment(-0.5, -0.5),
                  radius: 2.0,
                  colors: [Color(0xFF414C5C), Color(0xFF1F2226)],
                ),
              ),
              padding: const EdgeInsets.all(1),
              child: Container(
                decoration: BoxDecoration(
                  // Background gradient gelap seperti di design
                  gradient: const RadialGradient(
                    center: Alignment(-0.5, -0.5),
                    radius: 1.5,
                    colors: [Color(0xFF13181D), Color(0xFF08090A)],
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  controller: _searchController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 13,
                  ),
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.transparent,
                    hintText: 'Cari Pekerjaan, Perusahaan, dll',
                    hintStyle: TextStyle(
                      color: Color(0xFF43474D),
                      fontFamily: 'Inter',
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF919AA6),
                      size: 18,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildCircleAction(Icons.tune),
          const SizedBox(width: 8),
          _buildSvgAction(
            'assets/icons/Notifikasi-bell.svg',
            onTap: () => context.push('/notifications'),
          ),
          const SizedBox(width: 8),
          _buildCircleAction(Icons.bookmark_border),
        ],
      ),
    );
  }

  Widget _buildCircleAction(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF292D33)),
          color: const Color(0xFF050708),
        ),
        child: Icon(icon, color: const Color(0xFF919AA6), size: 18),
      ),
    );
  }

  Widget _buildSvgAction(String assetPath, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF292D33)),
          color: const Color(0xFF050708),
        ),
        padding: const EdgeInsets.all(7),
        child: SvgPicture.asset(
          assetPath,
          colorFilter: const ColorFilter.mode(
            Color(0xFF919AA6),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFDCEAFC) : const Color(0xFF08090A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFFDCEAFC) : const Color(0xFF292D33),
                ),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? const Color(0xFF050708) : const Color(0xFF919AA6),
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDCEAFC),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 2,
          color: const Color(0xFF4E8CCA),
        ),
      ],
    );
  }

  Widget _buildJobCard({
    required String title,
    required String company,
    required String location,
    required String type,
    required String level,
    required String salary,
    required String postedTime,
    required String logoPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [Color(0xFF7B8799), Color(0xFF292D33)],
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const RadialGradient(
            center: Alignment.topLeft,
            radius: 1.2,
            colors: [Color(0xFF13181D), Color(0xFF070809)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF292D33)),
                  ),
                  child: SvgPicture.asset(
                    logoPath,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFFDCEAFC),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        company,
                        style: const TextStyle(
                          color: Color(0xFF919AA6),
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  postedTime,
                  style: const TextStyle(
                    color: Color(0xFF43474D),
                    fontSize: 10,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip(type),
                _buildChip(level),
                _buildChip(location),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF292D33), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gaji / Bulan',
                      style: TextStyle(
                        color: Color(0xFF43474D),
                        fontSize: 10,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      salary,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF080E14),
                    side: const BorderSide(color: Color(0xFF4E8CCA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text(
                    'Lamar',
                    style: TextStyle(
                      color: Color(0xFF4E8CCA),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF292D33)),
        color: Colors.transparent,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF919AA6),
          fontSize: 11,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
