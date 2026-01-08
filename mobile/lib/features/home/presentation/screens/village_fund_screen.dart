import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class VillageFundScreen extends StatefulWidget {
  const VillageFundScreen({super.key});

  @override
  State<VillageFundScreen> createState() => _VillageFundScreenState();
}

class _VillageFundScreenState extends State<VillageFundScreen> {
  int touchedIndex = -1;

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
          'Alokasi Dana Desa',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHistoryCard(),
            const SizedBox(height: 24),
            _buildAllocationCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF292D33)),
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [Color(0xFF13181D), Color(0xFF070809)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF21262B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.history, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Riwayat Dana Desa',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF21262B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF292D33)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF9CA3AF), size: 14),
                    const SizedBox(width: 8),
                    Text(
                      'Agustus 2025',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFD1D5DB),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF), size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Berikut adalah ringkasan pemasukan dan pengeluaran Dana Desa yang tercatat secara transparan dan permanen di jaringan blockchain.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0B0C),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF292D33)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0052CC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 10),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '0xA9Ac43f5b5e381552...D2cbc4478E14573',
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.copy, color: Color(0xFF6B7280), size: 16),
                const SizedBox(width: 8),
                const Icon(Icons.open_in_new, color: Color(0xFF6B7280), size: 16),
                const SizedBox(width: 8),
                const Icon(Icons.help_outline, color: Color(0xFF6B7280), size: 16),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alamat Smart-Contract desa anda',
            style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '250.000.000',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Rupiah',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total pemasukan bulan ini',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '35.500.000',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Rupiah',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total pengeluaran bulan ini',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Transaksi',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jumlah Transaksi Bulan Ini',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Hari yang lalu',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Transaksi Terakhir',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: Text(
                    'Unduh Laporan (.pdf)',
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD1D5DB),
                    side: const BorderSide(color: Color(0xFF292D33)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.list, size: 16),
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Lihat Semua'),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD1D5DB),
                    side: const BorderSide(color: Color(0xFF292D33)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllocationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF292D33)),
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [Color(0xFF13181D), Color(0xFF070809)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF21262B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.pie_chart_outline, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Alokasi Dana Desa',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF21262B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF292D33)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF9CA3AF), size: 14),
                    const SizedBox(width: 8),
                    Text(
                      'Agustus 2025',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFD1D5DB),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF), size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Berikut adalah rincian alokasi Dana Desa. Anda dapat menekan setiap segmen pada diagram untuk melihat detail lebih lanjut mengenai program dan realisasi anggaran.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '972.748.267',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Rupiah',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total anggaran desa saat ini',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '291.824.480',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Rupiah',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dana terealisasi dari anggaran',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: _showingSections(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildLegendItem(const Color(0xFF86D982), '30.14%', 'Infrastruktur', 'Rp 293.225.978'),
          const SizedBox(height: 12),
          _buildLegendItem(const Color(0xFF229E28), '21.65%', 'Pemberdayaan Masyarakat', 'Rp 210.599.999'),
          // Add more legend items as needed based on the chart
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 160.0 : 150.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0: // 30.14%
          return PieChartSectionData(
            color: const Color(0xFF86D982),
            value: 30.14,
            title: '30.14%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        case 1: // 20.18%
          return PieChartSectionData(
            color: const Color(0xFF229E28),
            value: 20.18,
            title: '20.18%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        case 2: // 7.00%
          return PieChartSectionData(
            color: const Color(0xFF86D982).withOpacity(0.8),
            value: 7.00,
            title: '7.00%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        case 3: // 8.36%
          return PieChartSectionData(
            color: const Color(0xFF229E28).withOpacity(0.8),
            value: 8.36,
            title: '8.36%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        case 4: // 6.67%
          return PieChartSectionData(
            color: const Color(0xFF14532D),
            value: 6.67,
            title: '6.67%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 5: // 6.01%
          return PieChartSectionData(
            color: const Color(0xFF4ADE80),
            value: 6.01,
            title: '6.01%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        case 6: // 21.65%
          return PieChartSectionData(
            color: const Color(0xFF16A34A),
            value: 21.65,
            title: '21.65%',
            radius: radius,
            titleStyle: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF050708),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildLegendItem(Color color, String percentage, String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              percentage,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
