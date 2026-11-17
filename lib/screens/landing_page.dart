import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'katalog_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const String _heroImage =
      'https://images.unsplash.com/photo-1445116572660-236099ec97a0?auto=format&fit=crop&w=1200&q=85';
  static const String _aboutImage =
      'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=1000&q=85';

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openKatalog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KatalogPage()),
    );
  }

  void _scrollToAbout() {
    final target = _aboutKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pad = pagePadding(context);

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        shape: const Border(bottom: BorderSide(color: AppColors.headerBorder)),
        titleSpacing: pad,
        title: const BrandLogo(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(pad, width),
            _buildAbout(width),
            _buildContact(pad, width),
            _buildFooter(width),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── HERO ─────────────────────────
  Widget _buildHero(double pad, double width) {
    final h1Size = (width * 0.12).clamp(36.0, 47.0).toDouble();

    return Padding(
      padding: EdgeInsets.fromLTRB(pad, 55, pad, 65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('WARKOP LOKAL • JATI, SIDOARJO', showDot: true),
          const SizedBox(height: 17),
          HeadingEm(
            lead: 'Temukan menu favoritmu, ',
            em: 'mulai dari sini.',
            size: h1Size,
            height: 1.09,
          ),
          const SizedBox(height: 17),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 470),
            child: Text(
              'Jelajahi pilihan kopi, minuman segar, '
              'dan camilan dari Warkop STK Jati. '
              'Lihat menu dan harga dengan mudah.',
              style: AppText.sans(
                size: 14,
                color: AppColors.muted,
                height: 1.9,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 27,
            runSpacing: 18,
            children: [
              PillButton(label: 'Jelajahi Menu', onPressed: _openKatalog),
              _buildTextLink('Kenali warkop kami', _scrollToAbout),
            ],
          ),
          const SizedBox(height: 34),
          _buildHeroNote(),
          const SizedBox(height: 45),
          _buildHeroVisual(),
        ],
      ),
    );
  }

  Widget _buildTextLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.linkUnderline),
          ),
        ),
        child: Text(
          label,
          style: AppText.sans(
            size: 12,
            weight: FontWeight.w700,
            color: AppColors.coffee,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroNote() {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: AppColors.noteBg,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.auto_awesome,
            size: 18,
            color: AppColors.caramel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tempat sederhana, cerita istimewa.',
                style: AppText.sans(
                  size: 11,
                  weight: FontWeight.w700,
                  color: AppColors.coffee,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Informasi menu dalam satu halaman.',
                style: AppText.sans(size: 10, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Sudut atas melengkung 46% (elips) dan sudut bawah 18px, seperti
  /// `border-radius: 46% 46% 18px 18px` pada .hero-image.
  BorderRadius _archRadius(double w, double h) {
    return BorderRadius.only(
      topLeft: Radius.elliptical(w * 0.46, h * 0.46),
      topRight: Radius.elliptical(w * 0.46, h * 0.46),
      bottomLeft: const Radius.circular(18),
      bottomRight: const Radius.circular(18),
    );
  }

  Widget _buildHeroVisual() {
    const double visualHeight = 340;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: visualHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Garis bingkai di belakang foto (.hero-visual:before)
                Positioned(
                  left: -15,
                  top: -15,
                  right: 20,
                  bottom: 20,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.outline),
                      borderRadius: _archRadius(w - 5, visualHeight - 5),
                    ),
                  ),
                ),
                // Foto utama
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: _archRadius(w, visualHeight),
                      boxShadow: AppShadows.soft,
                    ),
                    child: ClipRRect(
                      borderRadius: _archRadius(w, visualHeight),
                      child: const NetworkPhoto(url: _heroImage, iconSize: 60),
                    ),
                  ),
                ),
                // Stiker "Ngopi santai"
                Positioned(
                  left: -15,
                  bottom: 25,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 175),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.paper,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: AppShadows.soft,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('☕', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Ngopi santai',
                              style: AppText.serif(size: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'di Warkop STK Jati',
                              style: AppText.sans(
                                size: 10,
                                color: AppColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Teks vertikal di sisi kanan (.hero-caption)
                Positioned(
                  right: -20,
                  top: visualHeight * 0.5,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'GOOD COFFEE, GOOD MOOD.',
                      style: AppText.sans(
                        size: 9,
                        color: AppColors.caption,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ───────────────────────── TENTANG KAMI ─────────────────────────
  Widget _buildAbout(double width) {
    final aboutPad = width * 0.06;

    return Padding(
      key: _aboutKey,
      padding: EdgeInsets.symmetric(horizontal: aboutPad, vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('CERITA KAMI'),
          const SizedBox(height: 10),
          const HeadingEm(
            lead: 'Lebih dari sekadar tempat ',
            em: 'ngopi.',
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 470),
            child: Text(
              'Warkop STK Jati menjadi tempat untuk '
              'beristirahat sejenak, berbincang, dan '
              'menikmati waktu bersama. Melalui katalog '
              'digital ini, kami ingin memudahkan '
              'pengunjung mengenal pilihan menu yang tersedia.',
              style: AppText.sans(
                size: 14,
                color: AppColors.muted,
                height: 1.9,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAboutPoint(
                  '01',
                  'Menu mudah dilihat',
                  'Informasi tersusun rapi berdasarkan kategori.',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildAboutPoint(
                  '02',
                  'Harga lebih jelas',
                  'Pengunjung dapat melihat harga sebelum datang.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          _buildAboutImage(),
        ],
      ),
    );
  }

  Widget _buildAboutPoint(String number, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: AppText.sans(
              size: 10,
              weight: FontWeight.w800,
              color: AppColors.caramel,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppText.sans(
              size: 12,
              weight: FontWeight.w700,
              color: AppColors.coffee,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppText.sans(
              size: 10,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        height: 300,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Garis bingkai bergeser (.about-image-wrap:after)
            Positioned(
              left: 18,
              top: 18,
              right: -18,
              bottom: -18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.outlineSoft),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: const NetworkPhoto(url: _aboutImage, iconSize: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── KONTAK ─────────────────────────
  Widget _buildContact(double pad, double width) {
    final cardPadH = (width - pad * 2) * 0.08;

    return Padding(
      padding: EdgeInsets.fromLTRB(pad, 0, pad, 60),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: cardPadH, vertical: 35),
        decoration: BoxDecoration(
          color: AppColors.coffee,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('KUNJUNGI KAMI', light: true),
            const SizedBox(height: 10),
            const HeadingEm(
              lead: 'Sampai jumpa di ',
              em: 'STK Jati.',
              color: AppColors.onCoffee,
              emColor: AppColors.lightCaramel,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingin menikmati suasana warkop secara langsung? '
              'Silakan kunjungi lokasi kami.',
              style: AppText.sans(
                size: 14,
                color: AppColors.contactText,
                height: 1.9,
              ),
            ),
            const SizedBox(height: 30),
            _buildContactItem(
              Icons.location_on,
              'Lokasi',
              'Jati, Sidoarjo, Jawa Timur',
            ),
            const SizedBox(height: 19),
            _buildContactItem(
              Icons.access_time,
              'Jam Operasional',
              'Silakan konfirmasi jam buka terbaru',
            ),
            const SizedBox(height: 19),
            _buildContactItem(
              Icons.contact_mail,
              'Media Sosial / Kontak',
              'Tambahkan nomor atau akun resmi warkop',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.contactBorder),
          ),
          child: Icon(icon, size: 19, color: AppColors.contactIcon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AppText.sans(
                  size: 9,
                  color: AppColors.contactLabel,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: AppText.sans(
                  size: 11,
                  weight: FontWeight.w700,
                  color: AppColors.onCoffee,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ───────────────────────── FOOTER ─────────────────────────
  Widget _buildFooter(double width) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(child: BrandLogo(titleSize: 10)),
              const SizedBox(width: 16),
              InkWell(
                onTap: _scrollToTop,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kembali ke atas',
                        style: AppText.sans(
                          size: 10,
                          weight: FontWeight.w700,
                          color: AppColors.coffee,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.arrow_upward,
                        size: 12,
                        color: AppColors.coffee,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} Warkop STK Jati Sidoarjo. '
            'Katalog menu digital.',
            style: AppText.sans(size: 10, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
