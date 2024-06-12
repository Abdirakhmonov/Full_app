import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:full_app/providers/settings_notifier.dart';
import 'package:full_app/services/registr_service.dart';
import 'package:full_app/utils/my_theme.dart';
import 'package:full_app/utils/routes_utild.dart';
import 'package:full_app/viewmodel/settings_controller.dart';
import 'package:full_app/views/screens/courses_info_screen.dart';
import 'package:full_app/views/screens/login_screen.dart';
import 'package:full_app/views/screens/main_page.dart';
import 'package:full_app/views/screens/registr_screens.dart';
import 'package:full_app/views/screens/settings_screen.dart';
import 'package:full_app/views/screens/todos_screen.dart';

import 'data/local_data.dart';
import 'models/course_model.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(
    themeModeData: LocalData(),
    sizeTextData: LocalData(),
  );
  await settingsController.loadTheme();
  await settingsController.loadSizeText();
  await settingsController.loadColorText();

  runApp(MainRunner(settingsController: settingsController));
}

class MainRunner extends StatefulWidget {
  final SettingsController settingsController;

  const MainRunner({super.key, required this.settingsController});

  @override
  State<MainRunner> createState() => _MainRunnerState();
}

class _MainRunnerState extends State<MainRunner> {
  final authHttpServices = AuthHttpService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    authHttpServices.checkAuth().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: MyThemMode.lightheme,
        dark: MyThemMode.nightTheme,
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return SettingsNotifier(
            settingsController: widget.settingsController,
            child: Builder(
              builder: (context) {
                final settingsNotifier = SettingsNotifier.of(context);
                return AnimatedBuilder(
                  animation: settingsNotifier,
                  builder: (context, child) {
                    return MaterialApp(
                      theme: theme,
                      darkTheme: darkTheme,
                      onGenerateRoute: (settings) {
                        if (settings.name == "/courseInfo") {
                          return MaterialPageRoute(
                              builder: (context) => CourseInfoScreen(
                                  course: settings.arguments as Course));
                        }
                        return null;
                      },
                      debugShowCheckedModeBanner: false,
                      themeMode: settingsNotifier.appTheme.themeMode,
                      home: isLoggedIn ? const HomePage() : LoginPage(),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
