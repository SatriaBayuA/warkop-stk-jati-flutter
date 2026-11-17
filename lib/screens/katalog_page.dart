import 'package:material_ui/material_ui.dart';

import '../data/menu_data.dart';
import '../models/menu.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'detail_menu_page.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Kopi',
    'Non-Kopi',
    'Makanan',
    'Camilan',
  ];

  List<Menu> get _filteredMenus {
    return MenuData.menus.where((menu) {
      final matchesCategory =
          _selectedCategory == 'Semua' || menu.category == _selectedCategory;

      final matchesSearch = menu.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      return matchesCategory && matchesSearch;
    }).toList();
  }

  String _formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.')}';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menus = _filteredMenus;
    final pad = pagePadding(context);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: buildPageAppBar(context, 'Katalog Menu'),
      body: CustomScrollView(
        slivers: [
          // Judul bagian (.section-heading)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, 58, pad, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('PILIHAN KAMI'),
                  const SizedBox(height: 10),
                  const HeadingEm(lead: 'Daftar ', em: 'Menu'),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Text(
                      'Temukan minuman dan makanan yang cocok '
                      'menemani waktu santaimu.',
                      style: AppText.sans(
                        size: 14,
                        color: AppColors.muted,
                        height: 1.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter kategori + kolom pencarian (.menu-toolbar)
          SliverToBoxAdapter(child: _buildCategoryList(pad)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, 10, pad, 28),
              child: _buildSearchBox(),
            ),
          ),

          // Daftar menu menggunakan grid 2 kolom
          if (menus.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 110),
                child: Center(
                  child: Text(
                    'Menu tidak ditemukan. Coba kata kunci lain.',
                    textAlign: TextAlign.center,
                    style: AppText.sans(size: 13, color: AppColors.muted),
                  ),
                ),
              ),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(pad, 0, pad, 70),
                child: GridView.builder(
                  // Grid berada di dalam CustomScrollView, jadi scroll utama
                  // tetap ditangani oleh CustomScrollView di halaman ini.
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 252,
                  ),
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return _buildMenuCard(menus[index]);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ───────────────────────── Filter kategori ─────────────────────────
  Widget _buildCategoryList(double pad) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: pad),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 9),
            child: _buildCategoryChip(category, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.coffee : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? AppColors.coffee : AppColors.chipBorder,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
            child: Text(
              category == 'Semua' ? 'Semua Menu' : category,
              style: AppText.sans(
                size: 11,
                weight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.chipText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── Kolom pencarian ─────────────────────────
  Widget _buildSearchBox() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.chipBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: AppColors.caramel),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: AppText.sans(size: 12, color: AppColors.ink),
              cursorColor: AppColors.caramel,
              decoration: InputDecoration.collapsed(
                hintText: 'Cari menu...',
                hintStyle: AppText.sans(size: 12, color: AppColors.hint),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Kartu menu ─────────────────────────
  Widget _buildMenuCard(Menu menu) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppColors.paper,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMenuPage(menu: menu),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 125,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetworkPhoto(url: menu.image, semanticLabel: menu.name),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tagBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        menu.category,
                        style: AppText.sans(
                          size: 9,
                          weight: FontWeight.w700,
                          color: AppColors.coffee,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.serif(size: 13),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Text(
                        menu.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.sans(
                          size: 9,
                          color: AppColors.muted,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatRupiah(menu.price),
                          style: AppText.sans(
                            size: 11,
                            weight: FontWeight.w800,
                            color: AppColors.caramel,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  'Lihat detail',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppText.sans(
                                    size: 9,
                                    weight: FontWeight.w700,
                                    color: AppColors.coffee,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.north_east,
                                size: 10,
                                color: AppColors.coffee,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
