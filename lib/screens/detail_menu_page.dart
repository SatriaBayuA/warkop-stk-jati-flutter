import 'package:material_ui/material_ui.dart';

import '../models/menu.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class DetailMenuPage extends StatelessWidget {
  final Menu menu;

  const DetailMenuPage({
    super.key,
    required this.menu,
  });

  String _formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (match) => '${match[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 300;
    const double sheetOverlap = 24;

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: buildPageAppBar(context, 'Detail Menu'),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Gambar menu
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: NetworkPhoto(
                url: menu.image,
                iconSize: 80,
                semanticLabel: menu.name,
              ),
            ),

            // Informasi menu (lembar putih melengkung di atas gambar)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: imageHeight - sheetOverlap),
              padding: const EdgeInsets.fromLTRB(25, 28, 25, 40),
              decoration: const BoxDecoration(
                color: AppColors.paper,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      menu.category.toUpperCase(),
                      style: AppText.sans(
                        size: 10,
                        weight: FontWeight.w800,
                        color: AppColors.caramel,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Nama menu
                  Text(
                    menu.name,
                    style: AppText.serif(
                      size: 30,
                      letterSpacing: -1.5,
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Harga menu
                  Text(
                    _formatRupiah(menu.price),
                    style: AppText.sans(
                      size: 20,
                      weight: FontWeight.w700,
                      color: AppColors.caramel,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.only(top: 18),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.line)),
                    ),
                    child: Text(
                      'Deskripsi Menu',
                      style: AppText.serif(size: 17, letterSpacing: -0.3),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Deskripsi
                  Text(
                    menu.description,
                    style: AppText.sans(
                      size: 13,
                      color: AppColors.muted,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Tombol kembali
                  SizedBox(
                    width: double.infinity,
                    child: PillButton(
                      label: 'Kembali ke Katalog',
                      icon: Icons.arrow_back,
                      iconLeading: true,
                      expand: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
