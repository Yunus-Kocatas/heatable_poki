import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:heatable_poki/utils/theme_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appRouter.dart';
import 'bindings/appBinding.dart';
import 'data/config/hive/hiveConfig.dart';

void main() async {
  await HiveConfig.init();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(!darkModeOn ? darkTheme : lightTheme),
          child: MyApp(
            router: AppRouter(),
          ),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heatable Api',
      theme: themeNotifier.getTheme(),
      // home: _buildStack()
      initialRoute: SPLASH_ROUTE,
      initialBinding: AppBinding(),
      onGenerateRoute: router.generateRoute,
      // getPages: routes,
    );
  }
}
