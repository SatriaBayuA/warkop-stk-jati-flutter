import 'package:material_ui/material_ui.dart';

import 'screens/landing_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const WarkopApp());
}

class WarkopApp extends StatelessWidget {
  const WarkopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warkop STK Jati',
      theme: AppTheme.light(),
      home: const LandingPage(),
    );
  }
}
