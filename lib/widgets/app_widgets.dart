import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

/// Kotak logo "STK" (.brand-mark).
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 38});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.coffee,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        'STK',
        style: AppText.serif(
          size: 15,
          weight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -1,
        ),
      ),
    );
  }
}

/// Logo + nama warkop (.brand).
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.markSize = 38, this.titleSize = 12});

  final double markSize;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandMark(size: markSize),
        const SizedBox(width: 11),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'WARKOP STK JATI',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.sans(
                  size: titleSize,
                  weight: FontWeight.w700,
                  color: AppColors.coffee,
                  letterSpacing: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Teman santai setiap hari',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.sans(size: 10, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Label kecil huruf kapital (.eyebrow).
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.light = false, this.showDot = false});

  final String text;
  final bool light;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final color = light ? AppColors.lightCaramel : AppColors.caramel;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDot) ...[
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.caramel,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 9),
        ],
        Flexible(
          child: Text(
            text,
            style: AppText.sans(
              size: 10,
              weight: FontWeight.w800,
              color: color,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

/// Judul Playfair dengan kata penekanan miring berwarna karamel (h1/h2 + em).
class HeadingEm extends StatelessWidget {
  const HeadingEm({
    super.key,
    required this.lead,
    required this.em,
    this.size = 36,
    this.height = 1.15,
    this.color = AppColors.coffee,
    this.emColor = AppColors.caramel,
  });

  final String lead;
  final String em;
  final double size;
  final double height;
  final Color color;
  final Color emColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: lead,
            style: AppText.serif(
              size: size,
              color: color,
              letterSpacing: -1.5,
              height: height,
            ),
          ),
          TextSpan(
            text: em,
            style: AppText.serif(
              size: size,
              weight: FontWeight.w600,
              color: emColor,
              letterSpacing: -1.5,
              height: height,
              style: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tombol pil berwarna kopi (.btn .btn-primary).
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.arrow_forward,
    this.iconLeading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final bool iconLeading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final labelText = Text(
      label,
      style: AppText.sans(
        size: 12,
        weight: FontWeight.w700,
        color: Colors.white,
      ),
    );
    final iconWidget = Icon(icon, size: 17, color: AppColors.arrow);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.coffee,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppShadows.button,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: iconLeading
                  ? [iconWidget, const SizedBox(width: 14), labelText]
                  : [labelText, const SizedBox(width: 22), iconWidget],
            ),
          ),
        ),
      ),
    );
  }
}

/// Foto jaringan dengan placeholder krem saat memuat / gagal memuat.
/// Ukuran mengikuti widget induk (gunakan SizedBox / Positioned.fill).
class NetworkPhoto extends StatelessWidget {
  const NetworkPhoto({
    super.key,
    required this.url,
    this.iconSize = 48,
    this.semanticLabel,
  });

  final String url;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      semanticLabel: semanticLabel,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ColoredBox(color: AppColors.cream);
      },
      errorBuilder: (context, error, stackTrace) {
        return ColoredBox(
          color: AppColors.cream,
          child: Center(
            child: Icon(
              Icons.coffee,
              size: iconSize,
              color: AppColors.coffee,
            ),
          ),
        );
      },
    );
  }
}

/// AppBar halaman dalam (Katalog, Detail) bergaya .site-header.
PreferredSizeWidget buildPageAppBar(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: 72,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.paper,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.coffee,
    iconTheme: const IconThemeData(color: AppColors.coffee),
    shape: const Border(bottom: BorderSide(color: AppColors.headerBorder)),
    titleSpacing: 0,
    title: Text(
      title,
      style: AppText.serif(
        size: 19,
        weight: FontWeight.w700,
        color: AppColors.coffee,
        letterSpacing: -0.3,
      ),
    ),
  );
}
