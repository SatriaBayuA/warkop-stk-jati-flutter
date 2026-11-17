import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet warna — diambil 1:1 dari `:root` dan nilai warna di style.css.
class AppColors {
  AppColors._();

  static const Color coffee = Color(0xFF4A2D20);
  static const Color coffee2 = Color(0xFF6A4430);
  static const Color caramel = Color(0xFFB77B4C);
  static const Color cream = Color(0xFFF7F2E9);
  static const Color paper = Color(0xFFFFFDF9);
  static const Color ink = Color(0xFF29231F);
  static const Color muted = Color(0xFF82766C);
  static const Color line = Color(0xFFE9E0D5);

  // Warna pendukung (nilai hex langsung dari style.css)
  static const Color chipBorder = Color(0xFFE2D5C7);
  static const Color chipText = Color(0xFF756A61);
  static const Color arrow = Color(0xFFE5B98E);
  static const Color outline = Color(0xFFD8C4AF);
  static const Color outlineSoft = Color(0xFFD9C7B5);
  static const Color noteBg = Color(0xFFF2E8DA);
  static const Color linkUnderline = Color(0xFFC9AA8E);
  static const Color caption = Color(0xFFA18A76);
  static const Color hint = Color(0xFF9B8D80);
  static const Color headerBorder = Color(0x124A2D20); // rgba(74,45,32,.07)
  static const Color cardBorder = Color(0x0F4A2D20); // rgba(74,45,32,.06)
  static const Color tagBg = Color(0xEDFFFDF9); // rgba(255,253,249,.93)

  // Kartu kontak (latar kopi)
  static const Color onCoffee = Color(0xFFFFF8EF);
  static const Color lightCaramel = Color(0xFFD5A77D);
  static const Color contactIcon = Color(0xFFE1B58D);
  static const Color contactBorder = Color(0xFF84644F);
  static const Color contactLabel = Color(0xFFC4A58D);
  static const Color contactText = Color(0xFFD4C4B6);
}

/// Bayangan — `--shadow` dan bayangan tombol utama.
class AppShadows {
  AppShadows._();

  // 0 18px 50px rgba(65,42,27,.10)
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x1A412A1B),
      blurRadius: 50,
      offset: Offset(0, 18),
    ),
  ];

  // 0 10px 24px rgba(74,45,32,.18)
  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color(0x2E4A2D20),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];
}

/// Gaya teks: Playfair Display untuk judul, DM Sans untuk isi (sama seperti web).
class AppText {
  AppText._();

  static TextStyle serif({
    double size = 16,
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.coffee,
    double? letterSpacing,
    double? height,
    FontStyle? style,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: style,
    );
  }

  static TextStyle sans({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.dmSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coffee,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.paper,
    );

    return base.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme),
      primaryTextTheme: GoogleFonts.dmSansTextTheme(base.primaryTextTheme),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.caramel,
        selectionHandleColor: AppColors.caramel,
      ),
    );
  }
}

/// Padding horizontal halaman: 5% lebar layar (section-wrap versi mobile).
double pagePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return (width * 0.05).clamp(16.0, 32.0).toDouble();
}
